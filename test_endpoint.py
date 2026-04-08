import boto3
import json
import time

# Create SageMaker runtime client
client = boto3.client("sagemaker-runtime", region_name="us-east-1")

endpoint_name = "test-endpointsss"

# Multiple test inputs
test_inputs = [
    "I love this product",
    "This is the worst experience ever",
    "It is okay, not bad",
    "Absolutely amazing!",
    "Very disappointing service"
]

def test_endpoint():
    print("\n===== ADVANCED ENDPOINT TESTING =====\n")

    for i, text in enumerate(test_inputs, 1):
        print(f"\nTest Case {i}")
        print("Input:", text)

        payload = {
            "inputs": text
        }

        try:
            start_time = time.time()

            response = client.invoke_endpoint(
                EndpointName=endpoint_name,
                ContentType="application/json",
                Body=json.dumps(payload)
            )

            end_time = time.time()

            result = json.loads(response["Body"].read().decode())

            # Validate response
            if isinstance(result, list) and "label" in result[0]:
                print("Output:", result)
                print("Status: ✅ Valid response")
            else:
                print("Status: ❌ Unexpected response format")

            print("Response Time:", round(end_time - start_time, 3), "seconds")

        except Exception as e:
            print("Status: ❌ Error occurred")
            print("Error:", str(e))


if __name__ == "__main__":
    test_endpoint()