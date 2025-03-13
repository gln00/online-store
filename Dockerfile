# # Basic image
# FROM python:3.12
#
# # Work directory
# WORKDIR /usr/src/app
#
# # Upgrade pip and install virtualenv
# RUN pip install --upgrade pip & \
# 	pip install virtualenv
#
# # Copy files
# COPY . .
#
# # Activate venv 
# RUN python -m venv venv & \
# 	virtualenv venv
#
# # Install requirements
# RUN pip --versoin \
# 	/usr/bin/pip install -r requirements.txt
#
# # Start migration and load data in db 
# RUN python OnlineStore/manage.py migrate
# RUN python OnlineStore/manage.py loaddata OnlineStore/data.json
#
# # Create user
# RUN python OnlineStore/manage.py createsuperuser
#
# # Port 
# # EXPOSE 8080
#
# CMD ["python3", "OnlineStore/manage.py", "runserver", "0.0.0.0:8000"]
# Basic image
FROM python:3.12

# Work directory
WORKDIR /usr/src/app

# Upgrade pip and install virtualenv
RUN pip install --upgrade pip && \
    pip install virtualenv

# Copy files
COPY . .

# Create and activate virtual environment
RUN python -m venv venv
ENV PATH="/usr/src/app/venv/bin:$PATH"

# Install requirements
RUN pip install -r requirements.txt

# Start migration and load data in db
RUN python OnlineStore/manage.py migrate
RUN python OnlineStore/manage.py loaddata OnlineStore/data.json

# Port
EXPOSE 8000

# Command to run the server
CMD ["python", "OnlineStore/manage.py", "runserver", "0.0.0.0:8000"]
