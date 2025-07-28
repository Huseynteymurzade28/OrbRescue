# OrbRescue
## Description
### OrbRescue is a fast-paced survival game built with Love2D. You control a spaceship (the "orb") and must avoid incoming enemies for as long as possible. The game features increasing difficulty, a point system, and a simple yet engaging gameplay loop. Perfect for testing your reflexes and focus!
## Features
        Smooth and responsive mouse controls
        Dynamic enemy spawning and increasing difficulty
        Score and level progression system
        Main menu and game over screens
        Custom spaceship drawing and visual effects
        Clean and modular code structure (Player, Enemy, Button modules)
## Installation
1. Clone the repository:
   ```bash
    git clone https://github.com/Huseynteymurzade28/OrbRescue.git
    ```
2. Navigate to the project directory:
    ```bash
    cd OrbRescue
    ```
3. Run the game using Love2D:
    ```bash
    love .
    ```
## Controls
- Move the spaceship by moving your mouse.
- Click to start the game from the main menu.
- Click "Try again" on the game over screen to restart.
- Click "Quit Game" to exit the game.
## Project Structure
- `main.lua`: The main entry point of the game, handling initialization, game states, and the main game loop.
- `Player.lua`: Contains the Player class, which manages the spaceship  
    drawing, movement, and collision detection.
- `Enemy.lua`: Contains the Enemy class, which manages enemy spawning, movement, and collision detection.
- `Button.lua`: Contains the Button class, which manages button creation, rendering, and click detection.
- `assets/`: Contains game assets such as images and sounds.
- `README.md`: This file, providing an overview of the game and instructions.
## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details