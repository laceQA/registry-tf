#!/usr/bin/env python3
"""
SageMaker Sentiment Analysis Client
This script invokes a SageMaker endpoint for sentiment analysis.
"""

import boto3
import json

def invoke_sentiment_analysis(endpoint_name, text):
    """
    Invoke the SageMaker endpoint for sentiment analysis.

    Args:
        endpoint_name (str): Name of the SageMaker endpoint.
        text (str): Text to analyze.

    Returns:
        dict: The response from the endpoint.
    """
    # Create a SageMaker runtime client
    sagemaker_runtime = boto3.client('sagemaker-runtime')

    # Prepare the input data
    input_data = {
        "inputs": text,
        "parameters": {
            "return_all_scores": True
        }
    }

    # Invoke the endpoint
    response = sagemaker_runtime.invoke_endpoint(
        EndpointName=endpoint_name,
        ContentType='application/json',
        Body=json.dumps(input_data)
    )

    # Parse the response
    result = json.loads(response['Body'].read().decode())

    return result

if __name__ == "__main__":
    # Example usage
    endpoint_name = "your-endpoint-name"  # Replace with your actual endpoint name
    sample_texts = [
        "I love this product! It's amazing.",
        "This is terrible. I hate it.",
        "It's okay, nothing special."
    ]

    for text in sample_texts:
        try:
            result = invoke_sentiment_analysis(endpoint_name, text)
            print(f"Text: {text}")
            print(f"Result: {result}")
            print("-" * 50)
        except Exception as e:
            print(f"Error analyzing text '{text}': {e}")