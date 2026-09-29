CREATE TABLE IF NOT EXISTS murder_mystery (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT NOT NULL,
    role VARCHAR(255) NOT NULL,
    game_id VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO murder_mystery (player_id, role, game_id) VALUES (1, 'murderer', 'game1');
INSERT INTO murder_mystery (player_id, role, game_id) VALUES (2, 'innocent', 'game1');