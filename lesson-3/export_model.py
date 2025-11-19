import torch
import torchvision.models as models

# Завантажуємо модель MobileNetV2
model = models.mobilenet_v2(pretrained=True)
model.eval()

# Dummy input для трасування
dummy_input = torch.randn(1, 3, 224, 224)

# TorchScript trace
traced_model = torch.jit.trace(model, dummy_input)

# Зберігаємо модель
traced_model.save("model.pt")
print("Model exported as model.pt")
