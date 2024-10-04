"""Live your life like it is your last."""


happiness_compounds_behaviors = {
    "Dopamine": [
        "Achieving/accomplishing goals",  # 95% - Strong evidence upon goal achievement
        "Anticipating rewards",  # 95% - Key role in reward anticipation
        "Completing tasks",  # 90% - Well-established link with task completion
        "Getting positive feedback",  # 90% - Strong link with social reward
        "Exercise",  # 90% - Well-established link
        "Eating delicious food",  # 85% - Clear evidence during pleasurable eating
        "Learning new skills",  # 85% - Associated with reward/learning pathways
        "Listening to music",  # 80% - Multiple studies show release during enjoyment
    ],
    "Testosterone": [
        "Exercise/Physical exercise",  # 95% - Strong evidence for increase
        "Sexual activity",  # 90% - Well-established link
        "Competition/Competitive activities",  # 85% - Multiple studies show increase
        "Winning",  # 80% - Can lead to short-term increases
        "Taking risks",  # 75% - Some evidence, bidirectional effect
        "Leadership roles",  # 75% - Some evidence of higher levels
        "Assertiveness",  # 70% - Bidirectional relationship
    ],
    "Serotonin": [
        "Exposure to sunlight/Sun exposure",  # 90% - Strong evidence for production
        "Healthy sleep patterns",  # 90% - Clear bidirectional relationship
        "Regular exercise",  # 85% - Well-established link
        "Positive social interactions",  # 85% - Strong evidence
        "Healthy diet",  # 85% - Clear link, especially with certain foods
        "Meditation",  # 80% - Multiple studies show increase
        "Spending time in nature",  # 80% - Several studies show boost
        "Gratitude practices",  # 75% - Growing evidence
    ],
    "Oxytocin": [
        "Physical touch (hugging, cuddling)",  # 95% - Very strong evidence
        "Social bonding/Socializing",  # 90% - Well-established link
        "Acts of kindness",  # 85% - Multiple studies show increase
        "Petting animals",  # 85% - Clear evidence when interacting with pets
        "Expressing empathy",  # 85% - Strong link
        "Giving/receiving gifts",  # 80% - Associated with prosocial behavior
        "Sharing meals",  # 75% - Can increase through social bonding
    ],
    "Cannabinoids": [
        "Intense exercise (runner's high)",  # 85% - Strong evidence
        "Meditation",  # 75% - Some evidence of effect
        "Yoga",  # 75% - Combination of exercise and meditation effects
        "Massage",  # 75% - May increase through physical stimulation and relaxation
        "Deep breathing exercises",  # 70% - May affect through stress reduction
        "Acupuncture",  # 70% - Some studies suggest effects
        "Relaxation techniques",  # 70% - General term, may affect through stress reduction
        "Eating certain foods (e.g., chocolate, truffles)",  # 65% - Some foods contain relevant compounds
    ],
    "Opioids": [
        "Intense exercise",  # 90% - Strong evidence for endorphin release
        "Laughter",  # 85% - Well-established link
        "Eating spicy foods",  # 85% - Clear evidence of release
        "Social connection/Positive social interactions",  # 80% - Associated with endogenous release
        "Listening to music",  # 75% - Some evidence of triggering release
        "Engaging in creative activities",  # 75% - Creative flow may be associated
        "Experiencing art",  # 70% - May trigger through emotional engagement
    ]
}

happiness_compounds_refreshments = {
    "Dopamine": [
        "Coffee",  # 95% - Well-established effect
        "Dark chocolate",  # 85% - Contains boosting compounds
        "Green tea",  # 80% - Contains L-theanine
        "Bananas",  # 75% - Contains tyrosine and vitamin B6
        "Berries and fruits (including blueberries)",  # 70% - Contain supportive antioxidants
        "Avocados",  # 65% - Contains supportive nutrients
        "Almonds",  # 60% - Contains tyrosine precursor
    ],
    "Testosterone": [
        "Oysters",  # 80% - High in zinc
        "Pomegranate juice",  # 75% - Some studies show increase
        "Leafy greens",  # 70% - Contain supportive micronutrients
        "Brazil nuts",  # 70% - High in selenium
        "Ginger tea",  # 65% - Some studies suggest modest increase
        "Fortified plant-based milk",  # 60% - Depends on fortification
        "Coconut water",  # 50% - Limited evidence, general health support
    ],
    "Serotonin": [
        "Omega-3 rich foods (like fish, nuts, seeds)",  # 90% - Strong evidence for support
        "Salmon",  # 85% - High in omega-3s
        "Coffee",  # 85% - May increase receptors over time
        "Green tea",  # 80% - Contains L-theanine
        "Probiotic-rich foods (like yogurt, kefir)",  # 80% - Growing evidence of gut-brain link
        "Chamomile tea",  # 75% - May increase indirectly through relaxation
        "Eggs",  # 75% - Contain tryptophan and vitamin D
        "Kiwi fruit",  # 70% - Contains precursors and vitamin C
        "Spinach",  # 70% - Contains folate
        "Tofu",  # 70% - Contains tryptophan
        "Pineapple",  # 65% - Contains serotonin, but dietary effects debated
    ],
    "Oxytocin": [
        "Yogurt",  # 65% - Probiotic content may influence via gut-brain axis
        "Chocolate milk",  # 60% - May increase indirectly through pleasure
        "Green tea",  # 60% - L-theanine may indirectly influence through relaxation
        "Caffeine-free herbal teas",  # 60% - May increase indirectly through relaxation
        "Cheese",  # 55% - Limited evidence, general satisfaction
        "Soy milk",  # 55% - Contains mildly influencing compounds
        "Pomegranate juice",  # 50% - Limited evidence, general health benefits
    ],
    "Cannabinoids": [
        "Hemp seed oil",  # 70% - Contains small amounts
        "Turmeric latte",  # 70% - Curcumin may interact with receptors
        "Lemon balm tea",  # 70% - May interact via GABA system
        "Echinacea tea",  # 65% - Some evidence of interaction
        "Rosemary-infused water",  # 65% - Contains interacting compounds
        "Flaxseed smoothies",  # 60% - May offer indirect support
        "Chia seed drinks",  # 60% - May offer indirect support
    ],
    "Opioids": [
        "Spicy food/Chili pepper-infused drinks",  # 85% - Strong evidence for endorphin release
        "Saffron milk",  # 70% - Some studies suggest mood effects
        "Herbal teas (like chamomile, peppermint)",  # 70% - May increase indirectly through relaxation
        "Ginger beer",  # 65% - May have mild pain-relieving effects
        "Cinnamon tea",  # 65% - May have mild pain-relieving effects
        "Lavender lemonade",  # 65% - May interact via GABA system
        "Vanilla latte",  # 60% - Mild mood-enhancing effects
        "Nutmeg-spiced beverages",  # 60% - Limited evidence of interaction
    ]
}
