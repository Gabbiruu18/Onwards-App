# Onwards App

A minimalist, AI-powered decision-support app that helps you navigate life's dilemmas. Onwards acts as a logical guide, providing structured 3-step action roadmaps and safety checks for everyday problems.

## Features
* **AI-Powered Roadmaps:** Uses Google's Gemini API to analyze dilemmas and generate clear, step-by-step solutions.
* **Safety Check:** Automatically evaluates decisions for potential physical, financial, or emotional risks.
* **Premium Dark UI:** A sleek, modern interface built entirely with pure Flutter widgets.
* **Secure Configuration:** Protects API keys using hidden environment variables.

## Tech Stack
* **Framework:** Flutter / Dart
* **AI Integration:** `google_generative_ai` (Gemini latest version)
* **Packages:** `flutter_dotenv`, `flutter_markdown`

## Getting Started

### Prerequisites
* Flutter SDK installed
* An API key from Google AI Studio

### Installation
1. Clone this repository.
2. Run `flutter pub get` in your terminal to install packages.
3. Create a file named `.env` in the root folder of the project.
4. Add your API key to the `.env` file like this (no quotes or spaces around the equals sign):
   `GEMINI_API_KEY=your_api_key_here`
5. Run the app on your preferred emulator or physical device.

## Author
**Gabriel Purificacion**
