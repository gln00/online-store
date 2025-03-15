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
RUN python3 -c 'from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())' > .env
RUN head -n 1 .env | cut -c 1-5
RUN ls -lah


# Start migration and load data in db
RUN python OnlineStore/manage.py migrate
RUN python OnlineStore/manage.py loaddata OnlineStore/data.json

# Port
EXPOSE 8000

# Command to run the server
CMD ["python", "OnlineStore/manage.py", "runserver", "0.0.0.0:8000"]

