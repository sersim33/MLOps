import torch
from PIL import Image
from torchvision import transforms
import sys

# Завантажуємо модель
model = torch.jit.load("model.pt")
model.eval()

# Обробка зображення
img_path = sys.argv[1] if len(sys.argv) > 1 else "test.jpg"
image = Image.open(img_path).convert("RGB")

preprocess = transforms.Compose([
    transforms.Resize(256),
    transforms.CenterCrop(224),
    transforms.ToTensor(),
    transforms.Normalize([0.485,0.456,0.406], [0.229,0.224,0.225])
])
input_tensor = preprocess(image).unsqueeze(0)

# Інференс
with torch.no_grad():
    outputs = model(input_tensor)
    probs = torch.nn.functional.softmax(outputs[0], dim=0)
    top3 = torch.topk(probs, 3)

print("Top 3 classes:", top3.indices.tolist())
print("Probabilities:", top3.values.tolist())
