-- Create extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Users table
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Dietary restrictions table
CREATE TABLE dietary_restrictions (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

-- User dietary restrictions junction table
CREATE TABLE user_dietary_restrictions (
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    restriction_id INTEGER REFERENCES dietary_restrictions(id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, restriction_id)
);

-- Image analyses table
CREATE TABLE image_analyses (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    image_url VARCHAR(500) NOT NULL,
    analyzed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Detected ingredients table
CREATE TABLE detected_ingredients (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    analysis_id UUID REFERENCES image_analyses(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    confidence DECIMAL(3,2) NOT NULL,
    category VARCHAR(100)
);

-- Recipe history table
CREATE TABLE recipe_history (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    recipe_id VARCHAR(100) NOT NULL, -- External API recipe ID
    viewed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert default dietary restrictions
INSERT INTO dietary_restrictions (name) VALUES 
('Vegetarian'),
('Vegan'),
('Gluten-Free'),
('Dairy-Free'),
('Nut-Free'),
('Keto'),
('Paleo'),
('Low-Carb');