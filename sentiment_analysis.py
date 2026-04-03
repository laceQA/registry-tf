#!/usr/bin/env python3
"""
AI Sentiment Analysis Script
This script performs sentiment analysis on text using a pre-trained model.
"""

from transformers import pipeline

def analyze_sentiment(text):
    """
    Analyze the sentiment of the given text.

    Args:
        text (str): The text to analyze.

    Returns:
        dict: Sentiment analysis result with label and confidence score.
    """
    # Load the sentiment analysis pipeline
    sentiment_pipeline = pipeline("sentiment-analysis")

    # Perform sentiment analysis
    result = sentiment_pipeline(text)[0]

    return {
        "label": result["label"],
        "confidence": result["score"],
        "text": text
    }

if __name__ == "__main__":
    # Example usage
    sample_texts = [
        "I love this product! It's amazing.",
        "This is terrible. I hate it.",
        "It's okay, nothing special."
    ]

    for text in sample_texts:
        result = analyze_sentiment(text)
        print(f"Text: {result['text']}")
        print(f"Sentiment: {result['label']} (Confidence: {result['confidence']:.2f})")
        print("-" * 50)