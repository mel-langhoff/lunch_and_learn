# Lunch & Learn README

This backend API connects to multiple external APIs to provide recipe and learning resources based on a specified country. It supports user registration, authentication, and the ability to favorite recipes.

## Learning Goals
- Expose an API that aggregates data from multiple external APIs
- Expose an API that requires an authentication token
- Implement Basic Authentication
- Expose an API for CRUD functionality
- Determine completion criteria based on the needs of other developers
- Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc.)

## Prerequisites
- Ruby 3.2.2
- Rails 7.1.3.4
- PostgreSQL

## Setup Instructions

```bash
# Clone the repository
git clone https://github.com/your-username/recipes-and-learning-resources-api.git
cd recipes-and-learning-resources-api

# Install dependencies
bundle install

# Setup the database
rails db:create
rails db:migrate

# Add your API keys to the credentials.yml.enc file
# Obtain your API keys and add them to config/credentials.yml.enc.

# Edit the credentials
EDITOR="nano" bin/rails credentials:edit

# Start the server
rails s
