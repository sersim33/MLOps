# MLOps
# Lesson-3: ML Inference Service with Docker

##  Опис проєкту
Проєкт демонструє створення простого inference-сервісу для PyTorch-моделі з використанням Docker.  
Мета проєкту:
- Налаштувати середовище розробки (Python, pip, venv, PyTorch, Django, Docker)
- Експортувати TorchScript-модель
- Запустити inference через Python скрипт та Docker (fat і slim образи)
- Порівняти розмір і склад Docker-образів

--- НЕОБХІДНІ КРОКИ:
## Тестування локально через Python
Перевірка роботи inference на прикладі зображення:
- python inference.py test.jpg

## Створення Docker-образів
## Fat-образ:
- docker build -f Dockerfile.fat -t fat-model .

## Slim-образ:
- docker build -f Dockerfile.slim -t slim-model .


## Запуск inference через Docker
## Fat-образ:
docker run --rm -v $(pwd)/test.jpg:/app/test.jpg fat-model python inference.py test.jpg
## Slim-образ:
docker run --rm -v $(pwd)/test.jpg:/app/test.jpg slim-model python inference.py test.jpg


