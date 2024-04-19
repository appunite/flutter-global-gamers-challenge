Welcome to Better World! A Flutter game created using Flame engine. Experience real-world challenges: clean energy, waste sorting, deforestation, and more. Watch the world change with your actions. Join us for a Better World!

- [DevPost Portfolio](https://globalgamers.devpost.com/submissions/466414-better-world)
- [Demo (Youtube)](https://youtu.be/alQBAHjyctM?si=TrreKLuBQmatyZ8z)

## Inspiration
Seeing organizations like Global Citizen leveraging technologies like Flutter to change the world and make a difference has motivated us profoundly. We aspire to join this initiative and raise awareness about the environmental challenges our world currently faces. At Appunite, we found interest in Flutter from the beta phase and seeing such actions, we decided to join! That's why we created Better World.

## What it does
Our project offers a fresh perspective on the world’s challenges. Instead of focusing on just one issue, we’ve created a changing world with 6 mini-games, each with its own gameplay and tackling a different global problem. Each game is designed not only to entertain but also to educate players about significant environmental and societal issues and inspire them to take action.

Here’s how we’re addressing six critical problems:
- *Solar Panel Cleanup* - This game underscores the importance of clean energy solutions, demonstrating how keeping solar panels clean is crucial for maximizing their efficiency and output.
- *Lights Out Challenge* - In this challenge, players help conserve energy and protect wildlife simply by turning off unnecessary lights. It’s a fun way to remind ourselves of the simple actions we can take to make a big difference.
- *Plant a Forest* - As players tap to plant trees, they’re also learning about the critical role forests play in combating climate change and maintaining biodiversity. Each tree planted in the game symbolizes a step towards combating deforestation.
- *Plastic Free* - Addresses ocean pollution by engaging players in cleaning up plastics that threaten marine life. This game brings attention to the persistence of marine pollution and the importance of active environmental stewardship.
- *Recycle Rush* - Teaches the importance of recycling correctly to reduce waste. By sorting recyclables into the correct bins, players learn proper recycling practices and their role in waste management.
- *Pipeline Puzzle* - Clean water is a necessity we often take for granted. In this game, fixing leaky pipelines not only prevents pollution but also saves vital water resources.
As players progress through each game, they earn points and see how their actions improve the Better World. They also collect badges that they can store in Google Wallet.

Our mini-games serve not only to point out the pressing issues but also to present viable solutions. Following each mini-gaming session, players, by the "Learn & Donate" button, are introduced to organizations actively engaged in effecting positive change in the respective fields. This allows players to not only educate themselves further on the issues but also to contribute financially to these noble causes.
Our goal is simple: raise awareness and encourage action. We want players to feel empowered to change the world.


## How we built it
Flutter and Dart helped us build the app's core, while Firebase managed the backend. Rive and Flame made the game engaging, and Figma helped design the user interface. We collaborated using Github and Slack. Together, these tools helped us create Better World, aiming to make a positive impact.

## Challenges we ran into
Ideation Phase - with numerous issues we aimed to address, the application underwent significant evolution from its initial concept. Striking a balance between educational content and engaging gameplay posed a considerable challenge.

Rive Animations - Rive, while promising, still a bit unstable technology, causing several issues such as malfunctioning triggers and refresh problems, which hindered the development process.

Understanding the basics of the Flame Engine - as newcomers to game development, we had to invest significant time in familiarizing ourselves with the fundamentals of the Flame engine.

State Management - While we typically rely on Bloc for state management, we found that controllers worked better for the game mechanism. Although ChangeNotifier and ValueNotifier were readily available in the Flutter template provided, managing screen refreshes proved to be more challenging, particularly to ensure proper functionality of Rive animations inputs on our main map.

## Accomplishments that we're proud of

In just 2 months, our small team successfully crafted a beautiful, functional, multi-platform (Android, iOS, MacOS, Desktop Web) and potentially impactful game using our favourite technology, Flutter. We're proud of delivering a product that has the potential to reach a wide audience and make a positive difference in the world.

## What we learned
We discovered the multitude of incredible organizations tirelessly working to improve our world.

We gained invaluable experience working within a real startup environment, where accountability extends beyond coding and graphics to deliver every aspect of the project.

We understood the basics of the Flame engine, diving into the game development and animation.

## What's next for Better World

Our next steps involve releasing the game on the Play Store and App Store to reach a wider audience. We aim to continue spreading awareness about the environmental issues highlighted in the game and inspire more individuals to take action. 


## How to run the project
To run the project you don't need any additional setup than cloning the repository. The game works on Android, iOS, MacOS and Web (desktop). 
Flutter version: 3.19