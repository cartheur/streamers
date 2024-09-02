const canvas = document.getElementById("gameCanvas");
const ctx = canvas.getContext("2d");

const gridSize = 20;
let snake = [{ x: 160, y: 160 }];
let direction = { x: gridSize, y: 0 };
let food = { x: 320, y: 320 };
let score = 0;

function update() {
    const head = { x: snake[0].x + direction.x, y: snake[0].y + direction.y };

    // Check collision with walls
    if (head.x >= canvas.width || head.x < 0 || head.y >= canvas.height || head.y < 0) {
        resetGame();
    }

    // Check collision with self
    for (let part of snake) {
        if (head.x === part.x && head.y === part.y) {
            resetGame();
        }
    }

    snake.unshift(head);

    // Check if snake eats food
    if (head.x === food.x && head.y === food.y) {
        score++;
        placeFood();
    } else {
        snake.pop();
    }

    render();
}

function render() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    snake.forEach(part => {
        ctx.fillStyle = "green";
        ctx.fillRect(part.x, part.y, gridSize - 2, gridSize - 2);
    });

    ctx.fillStyle = "red";
    ctx.fillRect(food.x, food.y, gridSize - 2, gridSize - 2);
}

function placeFood() {
    food.x = Math.floor(Math.random() * (canvas.width / gridSize)) * gridSize;
    food.y = Math.floor(Math.random() * (canvas.height / gridSize)) * gridSize;
}

function resetGame() {
    snake = [{ x: 160, y: 160 }];
    direction = { x: gridSize, y: 0 };
    score = 0;
    placeFood();
}

document.addEventListener("keydown", (event) => {
    if (event.key === "ArrowUp" && direction.y === 0) {
        direction = { x: 0, y: -gridSize };
    } else if (event.key === "ArrowDown" && direction.y === 0) {
        direction = { x: 0, y: gridSize };
    } else if (event.key === "ArrowLeft" && direction.x === 0) {
        direction = { x: -gridSize, y: 0 };
    } else if (event.key === "ArrowRight" && direction.x === 0) {
        direction = { x: gridSize, y: 0 };
    }
});

setInterval(update, 100);