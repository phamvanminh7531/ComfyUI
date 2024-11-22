# Use the official NVIDIA CUDA base image with Python 3.10 and CUDA 12.7
FROM nvidia/cuda:12.6.1-cudnn-runtime-ubuntu24.04

# Use the official NVIDIA CUDA base image with Python 3.10 and CUDA 12.7
# FROM nvidia/cuda:12.7-cudnn-runtime-ubuntu24.04

# Set environment variables to ensure proper handling of paths and avoid .pyc files
ENV PYTHONUNBUFFERED=1
ENV PIP_NO_CACHE_DIR=1


# RUN apt-get -y update \
#     && apt-get install -y software-properties-common \
#     && apt-get -y update \
#     && add-apt-repository universe
# RUN apt-get -y update
# RUN apt-get -y install python3
# RUN apt-get -y install python3-pip
# RUN apt-get -y install python3-venv

# Set working directory in the container
WORKDIR /app

# Install system dependencies required for ComfyUI (e.g., libglib2.0-0, ffmpeg, etc.)
RUN apt-get update && apt-get install -y \
    git \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender1 \
    ffmpeg \
    python3-pip \
    python3-dev \
    python3-venv \
    build-essential && \
    rm -rf /var/lib/apt/lists/*


# RUN apt-get update && apt-get install -y virtualenv

# Install virtualenv to create a Python virtual environment

# Create and activate a virtual environment in the container
RUN python3 -m venv /app/venv
ENV PATH="/app/venv/bin:$PATH"



# Copy requirements.txt to the container
COPY requirements.txt .

# Install Python dependencies in the virtual environment
RUN pip install -r requirements.txt

# Copy all application files into the container
COPY . .

# Expose the port that the application will use (e.g., port 8199 for a web app)
EXPOSE 8188

# Command to run ComfyUI, change this based on the app's entry point
CMD ["python3", "main.py"]
