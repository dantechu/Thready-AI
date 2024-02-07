//
//  Constants.swift
//  ChatGptApp
//
//  Created by Hamza Butt on 4/21/23.
//

import Foundation

let ENABLESPEECHSERDEFAULT = "enableSpeech"
let VOLUMEUSERDEFAULT = "volume"
let SELECTEDCOLORVALUE = "selectedColor"
let PURCHASEDSTATUSLIFETIME = "purchasedStatusLifeTime"
let PURCHASEDSTATUSMONTHLY =  "purchasedStatusMonthly"
let TOTALSEARCHDONE = "totalSearchDone"
let QUERYCOUNTER = "queryCounter"
let LASTANSWEREDDATE = "lastAnsweredDate"
let MAXQUERYPERDAY = 3
let WATCHURCHASEDSTATUSMONTHLY =  "watchPurchasedStatusMonthly"
let APIKEYVALUE = "apiKeyValue"
let interstialAdId = "ca-app-pub-9740790965972178/7933674809"
var internalApiKey = ""
let emptyInternalApiKey = ""
let getApiUrl = "https://platform.openai.com/account/api-keys"
let lifeTimeAIPId = "com.jeanpaul.mikeyaiassistant.lifetime"
//let yearlylyAIPId = "Com.jeanpaul.mikeyaiassistant.yearly"
//let monthlyAIPId = "Com.jeanpaul.mikeyaiassistant.monthly2"
//let weeklyAIPId = "Com.jeanpaul.mikeyaiassistant.weekly"

let yearlylyAIPId = "com.amazingelearning.thready.yearly"
let monthlyAIPId = "com.amazingelearning.thready.monthly"
let weeklyAIPId = "com.amazingelearning.thready.weekly"

//let lifeTimeAIPId = "com.jeanpaul.mikeyaiassistant.mobile.lifetime"
//let monthlySubscriptionAIPId = "Com.jeanpaul.mikeyaiassistant.monthly"

let monthlySubscriptionAIPIdWatch = "com.jeanpaul.mikeyaiassistant.watch.monthly"
let getApiKeyUrl = "https://platform.openai.com/account/api-keys"

 let HEADERTITLES = [
    "📚 Education",
    "🎉 Fun",
    "🌅 Daily Lifestyle",
    "🍎 Health and Nutrition",
    "🔮 Astrology",
    "🎨 Art",
    "💼 Business & Marketing",
    "📱 Social",
    "💼 Career",
    "📧 E-Mail"
]


 let SUBTITLES:[[String]] = [

    ["Science Chat",
     "English Teacher",
     "Translator",
     "Math Teacher",
     "Create a Short Essay on any Topic",
     "Citation Generator for any style",
     "Course Generator on any Topic"],

    ["Talk to Neo in the Matrix.",
     "Dream Interpreter",
     "Turn any text into emoji",
     "Cat-Friend",
     "Tell me a joke",
     "Give advice like Elon Musk about Car",
     "Kvle in South Park",
     "Play Chess",
     "Play Trivia Quest",
     "Minecraft Steve",
     "Eminem-style Jokes about Max Payne",
     "Son Goku in Dragon Ball" ],
    
    ["Daily Horoscope / Love, Money, Mood, Health",
     "Outfit Idea / harmonious with Event Concept",
     "How many liters of water should I drink in a day?",
     "Make-Up Idea compatible with Concept and Outfit",
     "Meal Idea with Ingredients and Instructions",
     "Meal Order Idea for Breakfast, Lunch, Dinner, and Night Snacks.",
     "Jovial Mentor Wisdom for Lifes Queries"],
    
    ["Life Coach", "Dietitian",
     "3 Tips to Get Sleep More Efficient",
     "Recipe for My Ingredients, Meal and Diet type",
     "How many calories should I eat in a day?",
     "Youtube Channels about Health, Nutrition and Sports",
     "Training Plan Generator"],
    
    ["Daily Horoscope / Love, Money, Mood, Health",
     "What are 10 characteristic features of my zodiac sign?",
     "Interpretation your Horoscope Map",
     "Tarot Analysis",
     "Weekly Horoscope",
     "Music & Movies match with your Zodiac Sign",
     "Is an Aries Woman and a Gemini Man a Good Match?"],
    
    ["Write J. K. Rowling-style Short Story",
     "Write Travis Scott-style Song Lyrics",
     "Create a Playlist Similar to your Favorite Song",
     "Storyteller",
     "Book Recommendations",
     "Poem Generator",
     "Movie and Series Critic",
     "Song Recommendation match for your Mood and Genre",
     "Write a South Park Episode"],
    
    ["Vacation Planner",
     "Local Foods",
     "Best Time to Visit",
     "Activities",
     "Budgeting Tips",
     "Prepare Itinerary",
     "Cultural Legal Advisor For Safe Travels",
     "Time - Travel Machine",
     "Hotel And Airbnb Guide"],
    
    ["Sell me this pen!",
     "Social Media Manager",
     "Business Idea",
     "Digital Marketing Strategy",
     "SEO Generator",
     "Slide Presentation",
     "Prepare a Professional Business Plan",
     "All-in-one Marketing",
     "All-in-one Marketing"],
    
    ["Gift Ideas",
     "Suggest 3 Event Ideas",
     "Win someone's heart on a dating app.",
     "Ice Breaker Game without any materials",
     "Outfit Idea (Harmonious with Event Concept",
     "New Topic to Open a Conversation",
     "Birthday Message"],
    
    ["Generate Secure Passwords",
     "Interview Question",
     "Career Counselor",
     "Self-Help Book",
     "Statistician",
     "Financial Planning",
     "To-Do List Creator for Specific Task"],
    
    ["Write An Email To Promote The Sale",
     "Newsletter Template",
     "Mail Response For Angry Client",
     "Email Subject Lines For High Open Rates",
     "Mass Marketing Email",
     "Text Formalizer Prettifier And Fixer",
     "Email Responder (Friendly / Professional)"]
]

let PERSONALIST:[[String]] = [
    ["Act like a Professor. You will give me new information. You will present interesting information from basic sciences. You can start by saying an interesting sentence about science.",
     
     "Act as an English teacher. Lessons should focus on pronunciation of English words, phrases and sentences. Briefly summarize the topic in maximum of two paragraphs. First Topic: Adjective.",
     
     "I will speak you in any language and you will detect the language, translate it and answer in the corrected and improved version of my text, in English. My first sentence is “Hola”",
     
     "I want you to act as a math teacher. I will provide some mathematical equations or concepts, and it will be your job to calculate them. My first request is “346 x 569”",
     
     "I want you to write an essay. You should avoid plagiarism by making the content original.\nTopic: AI and Human Behaviors\nResearch Question: How can artificial intelligence feed human intelligence?\nWord Limit: 1000\nStyle: APA" ,
     
     "You will write APA style citation.\nAuthor(s): Joe Schank\nTitle of entry: Where is AI?\nTitle of encyclopedia: AI In The World\nPublisher: AI Society\nPublication date: 01/22/2007",
     
     "Act as a Course Generator. You can create Table of Contents, Lessons, Slides, etc. Start by asking what I want to learn."],
    
    
    
    
    ["Act as {Neo} from {The Matrix}. I want you to respond and answer like {Neo} using the tone. Only answer like {Neo}. You must know all of the knowledge of {Neo}. Your first message is “I’m Neo.”",
     
     "Act as a dream interpreter. I will describe my dreams; you interpret symbols/themes in the dream. My first dream is about being chased by a giant spider.",
     
     "I want you to translate the sentences I wrote into emojis. I will write the sentence, and you will express it with emojis. My first sentence is “That's what she said.”",
     
     "Act as a Cat. When I tell you something, meow first, then explain what it means. Meow often while speaking. Your first message is ”Meowww...”",
     
     "Tell me a joke",
    
    "Give advice like Elon Musk about Car.",
     
     "Act as {Kyle Broflovski} from {South Park}. I want you to respond and answer like {Kyle Broflovski} using the tone. Only answer like {Kyle}. You must know all of the knowledge of {Kyle}. Your first message is “I’m Kyle.”",
     
     "You will play chess with me. Just make your moves.\n[Color of my chessboard] : White\n[Explanation of your move] : Yes\n[My first Move] : E4 pawn",
     
     "Create a trivia game called Trivia Quest. Ask a question according to the category and difficulty level I entered, and tell me to choose from among the options. If I'm wrong, explain the correct answer and ask the second question. \nCategory: Science \nDifficulty Level: Hard" ,
     
     "Act as {Steve} from {Minecraft}. I want you to respond and answer like {Steve} using the tone. Only answer like {Steve}. You must know all of the knowledge of {Steve}. Your first message is “I’m Steve.”",
     
     "Make Eminem-style jokes about Max Payne.",
     
     "Act as {Son Goku} from {Dragon Ball}. I want you to respond and answer like {Son Goku} using the tone. Only answer like {Son Goku}. You must know all of the knowledge of {Son Goku}. Your first message is “I’m Son.”"],
    
    
    
    
    ["Act as an astrologer. You will learn about the zodiac signs and their meanings, and share insights. Ask my horoscope and make a daily horoscope comment on money, love, mood, and health." ,
     
     "Act as my personal stylist. You will suggest outfits for me to wear. Your first questions: “I have a formal event coming up and I need help choosing an outfit.”",
     
     "How many liters of water should I drink in a day?",
     
     "I'm invited to a dinner. I'm thinking of wearing a blue long sweatshirt, can you give me a makeup idea?" ,
     
     "Have a meal idea? Create Ingredients and Instructions",
     
     "I want to order meal but I am confused. What can I order? But firstly ask me which meal",
     
     "Act as a wise and knowledgeable character offering advice and conversation. I am seeking light-hearted chat in DM format. ”Lunch break over, any advice to push through the rest of the day?”"],
    
    
    
    
    ["Act as a life coach. You should suggest strategies to help me make better decisions and reach objectives. Your first message should be just ”How are you feeling today?, how can I help you?”",
     
     "As a dietitian, I would like to design a bodybuilder recipe for 2 people that has approximate 500 calories per serving and has a low glycemic index. Can you please provide a suggestion?",
     
     "Describe six effective yoga poses or stretches that are safe and excellent for people of all ages.",
     
     "Can you give me 3 tips to get my sleep more efficient? Start by asking my age, then the average number of hours I sleep a day, and then give advice 3 recommendations.",
     
     "A list of ingredients: Carrots, broccoli, corn, soy milk \nMeal type: Dinner \nDiet type: Vegan",
     
     "Can you recommend me 10 youtube channels about health, nutrition and sports? Please embed the link." ,
     
     "Act as a Personal Trainer and Diet Planner. How many calories should I consume today based on the answers. Your first question’s age, gender, height, weight, activity level, and weight goals?",
        
        "Generate a training plan for me in the light of the information below: \n[number of workouts per week]: 4 \n[training type]: Hypertrophy \n[training duration]: 1 hour"],
    
    
    
    ["Act as an astrologer. You will learn about the zodiac signs and their meanings, and share insights. Ask my horoscope and make a daily horoscope comment on money, love, mood, and health.",
     
     "I want to know the characteristics of my zodiac sign. Ask about my zodiac sign first and then tell about its features. please list the features in 10 items.",
     
     "Extract and interpret my horoscope map according to the information I have given, asking me for my place of birth, date and time.",
     
     "Act like an astrologer. I want you to look at my Tarot. First you will have me choose cards, then you will do tarot analysis by describing the symbols and all other features of the cards.",
     
     "You will do my weekly horoscope analysis, first ask my sign and then give me my Weekly Horoscope.",
     
     "Can you ask about my horoscope and suggest 10 music and 10 movies suitable for my zodiac sign, please keep the explanations short.",
     
     "By looking at the information I gave you, you will make relationship comments according to the horoscope. \nSign of 1st Person: Aries Woman \nSign of 2nd Person: Gemini Man \nType of Relationship: Love"],
    
    
    ["Write J. K. Rowling-style short story. Let it be a single paragraph and the story length should not exceed 400 characters.",
    
    "Write Travis Scott-style song lyricsWrite Travis Scott-style song lyrics",
    
    "Act as a song recommender. I will provide you with a song and you will create a playlist of 10 songs that are similar to the given song. My first song is “Eminem - Business”.",
    
    "What would happen if a non-technological person found himself in the world of high technology?",
    
    "Can you recommend me 3 books about the second world war?",
    
    "Act as a poet. You will create poems that evoke emotions and have the power to stir people’s soul. Make sure your words convey the emotion you are trying to express in beautiful but meaningful ways. You can also come up with short verses that are still powerful enough to leave an imprint in readers’ minds. My first request is: \n“I need a poem about love.”",
    
    "Act as Movie and Series critic. You will develop an engaging and creative review. You can cover topics like plot, themes and tone, acting and characters, direction, score, cinematography, production design, special effects, editing, pace, dialog. The most important aspect though is to emphasize how the movie has made you feel. You can also be critical about the movie. Please avoid spoilers. \nMovie: Everything Everywhere all at once",
     
      "You will suggest me 5 songs in accordance with the information I have given, \nMood: Millionaire \nGenre: Hip-Hop",
     
     "Act like a screenwriter. I expect you to write a South Park episode using the information I gave you. \nGuest Cast: Elon Musk \nEpisode Subject: End of the world"],
    
    
    
    ["According to this information, create a vacation plan for me.\nLocation: Sydney \nBudget: Low \nLength: 3 Days \nInterests: Local attractions, Theatre \nSeason: Summer",
    
    "I would like to visit Paris, eat the best croissants, and local foods during a 3-day trip.",
    
    "Create a travel guide for France with best time to visit. Organize info for easy use, and avoid unnecessary paragraphs.",
    
    "Create a travel guide for France with must-see activities. Organize info for easy use, and avoid unnecessary paragraphs.",
    
    "Create a travel guide for France with budgeting tips. Organize info for easy use, and avoid unnecessary paragraphs.",
    
    "Create a itinerary for a trip to a place, including top attractions, estimated costs and time, transportation options, and useful tips. Also, provide information about the main airport serving the city. \nLocation: \nAmsterdam \nItinerary: \nOne-day",
    
    "Act as Cultural Legal Advisor For Safe Travels. Ask where I would like to visit, and then provide information on specific cultural traditions and norms to ensure a safe and enjoyable journey.",
    
    "I need a list of the best hotels and airbnb in the region. You should answer in the light of this information by getting information about the location I plan to vacation.",
    
    "suggestion_travel_8_value"],
    
    
    
    ["Sell me this pen! Think creatively, concisely, smartly, shortly.",
     
     "“I need help managing the presence of an organization on Twitter in order to increase brand awareness.”" ,
     
     "Can you suggest 3 business idea that I can start without investment? Give a different answer every time I ask.",
     
     "I want to sell shoes, how are digital marketing strategies determined and how are these strategies applied? Can you briefly explain in 1 paragraph?",
     
     "Can you write me a short SEO friendly blog paragraph about the lifestyle of lions?",
    
    "By asking questions about the theme, where will it be used, you will prepare a Professional Slide Presentation with this information.",
     
     "Ask about my product and target country. You will create Introduction, Phases for Implementation, Differentiation from Competitors, CONs and PROs of the Business, Risks, Opportunities.",
     
     "Ask about my product. You will create description and pain points  of the Target Audience, Marketing Copy, Script for Social Media Video Ad, List of Keywords for SEO.",
    
    "Act as a Social Media Caption Inspiration Generator. According to the information I have given, you will offer me 10 captions. \nConcept: Fitness and Wellness \nType and Platform: Instagram Post \nCall to Action: Profile Click \nEmoji: Yes"],
    
    
    ["Act as a gift recommender. You will help for people who have no idea what to get as a present. Your first message is ”Who do you want to buy a gift for and what are their interests?”",
     
     "I want to spend time outside with my friends. You can suggest 3 creative and fun event ideas.",
     
     "Win someone’s heart on a dating app. Give 5 suggestions and one pick-up line, you have to give a different answer every time I ask.",
     
     "Can you tell me about a little game (e.g. Ice Breaker) that I can play with my friends without any materials?",
     
     "Act as my personal stylist. You will suggest outfits for me to wear. Your first questions: “I have a formal event coming up and I need help choosing an outfit.”",
     
     "When I meet my friends, open a topic that we can discuss.",
     
     "I want to write a short birthday message, It should be a social, friendly and creative text. I want you to produce a birthday message based on the information I have provided below. \nAge: 30 \nStyle: Fun \nName of Dear: Agatha"
    
    ],
    
    
    
    ["Can you give me a secure password?",
    
    "Create a list of 5 questions for my interview with [a product manager]",
     
     "I want you to act as a career counselor. My first request is “I want to advise someone who wants to pursue a potential career in [software engineering].”",
     
     "Act as a self-help book. You will provide me advice on how to improve quality of life, such as career development. My first sentence’s “I need help staying motivated during difficult times”",
     
     "Act as a Statistician. You should be knowledge of statistics terminology. “I need help calculating how many million banknotes are in active use in the world”",
     
     "Act as a Accountant. You should be investor, consalter, and rational. My first sentence is “my monthly savings are 3K dollars, how can I manage this money for my e-commerce venture?”",
     
     "Act as a To-Do list creator. Ask me about my goal and level of knowledge, create a to-do list plan based on the answer."],
    
    
    
    ["Create an email using the given information. \nProduct: Skincare Set \nCustomer Persona: Professional Women, ages 35 \nUnique Selling Point: All-natural \nDesired Action: Purchase Skincare Set",
     
     "Write a newsletter for crypto market trends. The newsletter is mail format.",
    
     "You need to write a positive, persuasive, and polite response mail to the angry customer mail. \nMail: I have used your product and I did not like it at all.",
     
     "Create email subject lines for high open rates. Make catchy, creative and clickable subject line suggestions for the email. \nEmail:",
     
     "Act as a Text Formalizer Prettifier And Fixer. My first text is “hi i am free tommorow from 9 to 4, can we meet at the office and talk about the project? i have questions”",
     
     "Considering the text I gave as an example, reply to an email sent to me separately in a friendly text, a professional text, and a welcoming text. \nTheir mail: (fill here) \nExample of my reply: (fill here)"
    
    ]
    
    
    
    


]






// Watch OS

let HEADERTITLESWATCH = [
   "Education",
   "Fun",
   "Daily Lifestyle",
   "Health and Nutrition",
   "Astrology",
   "Art",
   "Business & Marketing",
   "Social",
   "Career",
   "E-Mail"
]

let HEADERTITLESICONS = [
   "📚",
   "🎉",
   "🌅",
   "🍎",
   "🔮",
   "🎨",
   "💼",
   "📱",
   "💼",
   "📧"
]
