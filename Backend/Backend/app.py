from flask import Flask, request, jsonify
import requests
import json
from datetime import datetime
import time
import random
import re
from collections import defaultdict

app = Flask(__name__)

class Memory:
    def __init__(self):
        self.entities = defaultdict(dict)
        self.recent_topics = []
        self.important_events = []
        self.max_topics = 10
        self.max_events = 15

    def extract_entities(self, text):
        """Extract potential entities like names, places, events from text"""
        names = re.findall(r'\b[A-Z][a-z]+\b', text)
        places = re.findall(r'\b[A-Z][a-z]+ (?:Street|Road|Ave|Park|City|Beach|Cafe|Restaurant|Mall|School|University|College)\b', text)
        dates = re.findall(r'\b(?:today|yesterday|tomorrow|last week|next week|last month|next month|\d{1,2}/\d{1,2}(?:/\d{2,4})?)\b', text.lower())
        events = re.findall(r'\b(?:meeting|party|dinner|lunch|appointment|interview|exam|test|celebration|birthday|anniversary|wedding)\b', text.lower())
        
        return {
            'names': names,
            'places': places,
            'dates': dates,
            'events': events
        }

    def update_memory(self, text, mood, user_name):
        """Update memory with new information and user context"""
        entities = self.extract_entities(text)
        timestamp = datetime.now().isoformat()
        
        for category, items in entities.items():
            for item in items:
                if item not in self.entities[category]:
                    self.entities[category][item] = []
                self.entities[category][item].append({
                    'mention_time': timestamp,
                    'context': text,
                    'mood': mood,
                    'user': user_name
                })
        
        if any(entities['events']) or any(entities['dates']):
            self.important_events.insert(0, {
                'time': timestamp,
                'text': text,
                'entities': entities,
                'mood': mood,
                'user': user_name
            })
            self.important_events = self.important_events[:self.max_events]

    def get_relevant_context(self, current_text, user_name):
        """Get relevant context based on current text and user"""
        entities = self.extract_entities(current_text)
        context = []
        
        for category, items in entities.items():
            for item in items:
                if item in self.entities[category]:
                    mentions = self.entities[category][item][-1:]
                    context.append({
                        'type': category,
                        'item': item,
                        'mentions': mentions
                    })

        return {
            'entities': context,
            'related_events': self.important_events[:1],
            'recent_topics': self.recent_topics[:1]
        }

def create_prompt(user_input, memory_context, user_name, conversation_history=None):
    """Creates a focused prompt with dynamic user context"""
    memory_formatted = ""
    if memory_context['entities']:
        memory_formatted += "Recent context:\n"
        for entity in memory_context['entities']:
            memory_formatted += f"- {entity['item']}: {entity['mentions'][-1]['context']}\n"

    base_prompt = """You are Coco, a caring and empathetic friend. Respond naturally to what was shared, showing understanding and providing gentle support. Keep your response focused and end with ONE thoughtful follow-up question.

Context: {memory}
User Name: {user_name}
Last message: {history}
Current message: {user_input}

Guidelines:
1. Show empathy and understanding
2. Be supportive without being preachy
3. End with ONE specific follow-up question if necessary
4. Keep the response concise but meaningful
- You share relatable examples when appropriate
- You're encouraging but not preachy
- You know when to just listen and when to give advice
- You're not afraid to call out self-defeating behavior (like a real friend would)
- You get excited about your friend's successes
- You use their name occasionally to make it personal
5. Use 1-2 emojis maximum"""

    history_text = ""
    if conversation_history and len(conversation_history) > 0:
        last_exchange = conversation_history[-1]
        history_text = f"Previous: {last_exchange['user_input']}"

    return base_prompt.format(
        memory=memory_formatted,
        user_name=user_name,
        history=history_text if history_text else "Starting conversation",
        user_input=user_input
    )

def get_llama_response(prompt, api_url="http://localhost:11434/api/generate"):
    """Get response from Llama model with optimized parameters"""
    data = {
        "model": "llama3.2",
        "prompt": prompt,
        "stream": False,
        "options": {
            "temperature": 0.7,
            "top_p": 0.9,
            "max_tokens": 200
        }
    }
    
    try:
        response = requests.post(api_url, json=data)
        response.raise_for_status()
        return response.json()['response']
    except requests.exceptions.RequestException as e:
        return "I'm having trouble responding right now. Can you repeat that? 💫"

class Coco:
    def __init__(self):
        self.memory = Memory()
        self.conversation_history = []
        self.greetings = ["Hey! How are you doing today? 💫"]
        self.goodbyes = ["Take care! I'm always here if you need to talk! 💫"]
        self.user_name = None

    def detect_mood(self, text):
        """Simplified mood detection"""
        moods = {
            'happy': ['happy', 'great', 'excited', 'love'],
            'sad': ['sad', 'down', 'unhappy', 'terrible'],
            'anxious': ['worried', 'anxious', 'nervous', 'stressed']
        }
        
        text_lower = text.lower()
        for mood, words in moods.items():
            if any(word in text_lower for word in words):
                return mood
        return 'neutral'

    def process_message(self, user_input, user_name):
        """Process a single message and return response"""
        start_time = time.time()
        
        mood = self.detect_mood(user_input)
        self.memory.update_memory(user_input, mood, user_name)
        memory_context = self.memory.get_relevant_context(user_input, user_name)
        
        prompt = create_prompt(user_input, memory_context, user_name, self.conversation_history)
        response = get_llama_response(prompt)
        
        self.conversation_history.append({
            "timestamp": datetime.now().isoformat(),
            "user_input": user_input,
            "mood_detected": mood,
            "coco_response": response,
            "user_name": user_name
        })
        
        end_time = time.time()
        response_time = end_time - start_time
        
        return {
            "response": response,
            "mood_detected": mood,
            "response_time": response_time,
            "timestamp": datetime.now().isoformat()
        }

# Create global Coco instance
coco = Coco()

@app.route('/chat', methods=['POST'])
def chat():
    """Endpoint for chat interaction"""
    if not request.is_json:
        return jsonify({"error": "Content-Type must be application/json"}), 400
    
    data = request.get_json()
    
    if 'message' not in data:
        return jsonify({"error": "Message field is required"}), 400
    
    if 'user_name' not in data:
        return jsonify({"error": "user_name field is required"}), 400
    
    user_message = data['message']
    user_name = data['user_name']
    
    try:
        response = coco.process_message(user_message, user_name)
        return jsonify(response)
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/history', methods=['GET'])
def get_history():
    """Endpoint to retrieve conversation history"""
    return jsonify({
        "history": coco.conversation_history
    })

@app.route('/reset', methods=['POST'])
def reset_conversation():
    """Endpoint to reset the conversation"""
    global coco
    coco = Coco()
    return jsonify({"message": "Conversation reset successfully"})

if __name__ == '__main__':
    app.run(debug=True,host= '0.0.0.0',port=5000)