# General Plan
The plan in general lines is to reimplement the paper: 
"Object-based attention for spatio-temporal reasoning: Outperforming neuro-symbolic models with 
flexible distributed architectures"
by using the PySlowFast framework. Then we will modify it using video techniques.

Use visualization tools.

# Plan to modify SlowFast to implement a new model:
- Use the framework => Use the functions and the tools folder to train and test the model.
- The model is built in the build_model() function
    - from slowfast.models import build_model
    - The new model should be built based on this function.
- The models are defined in the slowfast/models/video_model_builder.py
    - Using a Registry (What is this ?)
    - The registry is accessed by build_model()


