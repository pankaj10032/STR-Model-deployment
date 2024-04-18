from flask import Flask, jsonify, request, render_template
import torch
# from langdetect import detect, DetectorFactory

import os
from transformers import XLMRobertaForSequenceClassification, AutoTokenizer
from transformers import RobertaForSequenceClassification

app = Flask(__name__)

class Predictor:
    def __init__(self, model, tokenizer, device):
        self.model = model
        self.tokenizer = tokenizer
        self.device = device

    def predict_similarity(self, sentence1, sentence2):
        try:
            # Tokenize input sentences
            encoded_input = self.tokenizer(sentence1, sentence2, return_tensors='pt', padding=True, truncation=True)
            input_ids = encoded_input['input_ids'].to(self.device)
            attention_mask = encoded_input['attention_mask'].to(self.device)

            # Perform inference
            with torch.no_grad():
                outputs = self.model(input_ids=input_ids, attention_mask=attention_mask)
                logits = outputs.logits
                similarity_score = torch.sigmoid(logits).item()  # Assuming binary classification
            return similarity_score
        except Exception as e:
            print(f"Error during model prediction: {e}")
            return 0.0  # Return a default or error value if any exception occurs

# Load model and tokenizer
# model_path = "pankaj100567/semantic_textual_relatedness"
# model_path="pankaj100567/str_english_model_roberta_large_1stage"
# model_path= "epoch_1"
# model_path="pankaj100567/semantic-english-model"
model_path="pankaj100567/semeval-semantic-texutal-relatedness"
# cache_dir = "/app/cache/huggingface"
cache_dir = "/code/cache/huggingface"
if not os.path.exists(cache_dir):
    try:
        os.makedirs(cache_dir)
        os.chmod(cache_dir, 0o777)  # Set directory permissions to read, write, and execute by all users
    except Exception as e:
        print(f"Failed to create or set permissions for directory {cache_dir}: {e}")

model = XLMRobertaForSequenceClassification.from_pretrained(model_path, cache_dir= cache_dir, num_labels=1)
tokenizer = AutoTokenizer.from_pretrained("xlm-roberta-large",cache_dir= cache_dir,)

# model = XLMRobertaForSequenceClassification.from_pretrained(model_path)
# tokenizer = AutoTokenizer.from_pretrained("xlm-roberta-large")

# Device configuration
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model.to(device)

# Initialize Predictor instance
predictor = Predictor(model, tokenizer, device)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/predict', methods=['POST'])
def predict():
    sentence1 = request.form['sentence1']
    sentence2 = request.form['sentence2']
    similarity_score = predictor.predict_similarity(sentence1, sentence2)
    return render_template('result.html', sentence1=sentence1, sentence2=sentence2, similarity_score=similarity_score)

# if __name__ == '__main__':
#     app.run(debug=True, host='0.0.0.0', port=5002)  # Ensure the app is accessible externally
