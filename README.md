# Word Guessing Game iOS App
# Brief Overview:

This is an iOS game app where app picks one secret word from the displayed words list and user has to guess that secret word from the displayed words list using app provided hint. There are 5 levels and with each level difficulty increases.

# Goals:

The application will be a game to guess a word and the app will function as follows

 - New users have to register for the game by providing email-id and password
 - Old Users have to login to start the game using email-id and password
 - At each level, app provides logout button. If user clicks the logout button, app will take the user to login page
 - At each level, app displays a list of words and randomly selects one word from that list as a secret word (not visible to users)
 - When the user starts to guess the secret word from the displayed words list, app displays how many letters the word has in common with the secret word they are trying to guess, without regard to position or case-sensitivity (See "Examples" below)
      
      words "TEA, EAT, TEE, PEA, PET, APE" and the game selects TEA as the secret word then:

       - PET will respond with 2 matches and decrement the number of attempts by 1 then allow a new guess
       - TEE will respond with 2 matches and decrement the number of attempts by 1 then allow a new guess
       - tee will respond with 2 matches and decrement the number of attempts by 1 then allow a new guess
       - EAT will respond with 3 matches and decrement the number of attempts by 1 then allow a new guess
       - TEA will respond that they have won the level allow them to move to a next level with a new randomly selected word from the new words list

 - If the user guesses the correct secret word within specified attempts at each level (except 1st level where user will have unlimited attempts), app allows the user to go next level whereas at the final 5th level, app allows the user to play again from the 1st level and also app display in the levels page that user completed all 5 levels x times
 - If the user doesn’t guess the correct secret word within specified attempts at 2nd/3rd/4th/5th levels, app won’t allow the user to go next level and ask user to play again the same level
 - User can continue to play with the next previous completed level if user logout in between the game
 - User can go to the levels page anytime

# Specifications:

 - App has login and register page
 - App uses rapid words API: https://wordsapiv1.p.rapidapi.com/words/?rapidapi-key=******************** (Links to an external site.)
 - App uses firebase for authentication
 - App uses firestore database
 - App has 5 table views and 9 VC
 - Auto layout

# Levels specification:

# 1st level
 - unlimited attempts
 - 9 words each of length 3

# 2nd level
 - 7 attempts
 - 12 words each of length 4

# 3rd level
 - 6 attempts
 - 15 words each of length 5

# 4th level
 - 5 attempts
 - 15 words each of length 6

# 5th level
 - 4 attempts
 - 15 words each of length 7
