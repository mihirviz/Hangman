% define main function
function finalHangman()

    % function: hangman figure 
    function dispHangmanFigure(numIncorrectGuesses, incorrectGuessesMaximum)
        % hangman figure to be displayed when incorrect letter is entered 
        hangmanFigure = {...
            ' ____ ',...
            '|    |',...
            '|    O',...
            '|   /|\',...
            '|   / \',...
            '|_______',...
        };

        % ensures values are positive
        numIncorrectGuesses = max(0, numIncorrectGuesses);
        incorrectGuessesMaximum = max(1, incorrectGuessesMaximum);

        % ensure hangman figure is displayed in correspondence to number of
        % incorrect guesses
        figureRatio = numIncorrectGuesses / incorrectGuessesMaximum;

        % round up to nearest whole number
        figuresNum = ceil(figureRatio * length(hangmanFigure));
    
        % display the applicable number of parts of the hangman figure 
        for j = 1:figuresNum
            disp(hangmanFigure{j});
        end 
    end

    % function: show selected word as underscores (__)
    function dispWordGuessed(term, guessedLetters)
        % 
        hiddenTerm = term;

        % replace letters of the word with underscore 
        hiddenTerm(~ismember(term, guessedLetters)) = '_';
        fprintf(("\n"))

        % display the word, hidden using underscores
        disp(['Word: ', join(hiddenTerm)]);

        % show the user how many letters are in the word 
        fprintf("This word has %d letters", length(term))
        fprintf("\n")
    end

    % function: validate the user's attempt at guessing
    function userGuess = validateUserGuess(lettersGuessed)
        % initialise to false
        inputValidity = false;
        while ~inputValidity
            % user input for a letter
            userGuess = upper(input("Enter a letter to guess: ", 's'));
            if length(userGuess) ~= 1
                disp("ERROR: Please enter a single letter")
            elseif ~isletter(userGuess) || numel(userGuess) > 1 || ismember(userGuess, lettersGuessed)
                disp("Guess is invalid. Please enter a single letter or guess a letter that you have not used yet.");
            else
                % otherwise set to true 
                inputValidity = true;
            end 
        end
    end 

    % function: check if letter is in the word
    function existance = letterExistanceCheck(letter, term)
        % initialise 'existance' to false 
        existance = false;

        % iterate over every letter of the word
        for k = 1:length(term)
            % check if the letter is in the word
            if term(k) == letter
                existance = true; % if letter is in the word, change 'existance' to true
                break;
            end 
        end 
    end 

    % show user welcome message
    disp("------------- Welcome to Hangman! ------------------")
    pause(1.0) % add some delay so user can read each message clearly
    disp("------ Test Yourself through Different Levels ------")
    pause(1.0)
    disp("--- Apply your knowledge on different Categories ---")
    fprintf("\n")
    pause(0.5)
    
    % get user name
    nameUser = input("Please enter your name: ", 's');
    fprintf("\n")

    % show the user game rules
    fprintf("Hi %s! Great to see you playing Hangman! Here are the rules:", nameUser)
    fprintf("\n")
    disp("1. Enter letters to guess the word from the category you choose")
    disp("2. Guess the secret word before you run out of lives and the stick figure is hung")
    disp("3. Make sure not to guess the same letter again")
    disp("4. Once you run out lives, the game will end and the word will be revealed")
    fprintf("\n")
    pause(2.0)

    % initialise to true for while loop
    play = true; 
    while play
        % set and initialise variables
        levelDifficulty = ['EASY', 'INTERMEDIATE', 'HARD', 'PRO'];
        wordCategories = ['SPORTS', 'ANIMALS', 'INSTRUMENTS', 'FRUITS', 'COUNTRIES', 'COLOURS', 'RANDOM'];
        wordChosen = '';
        incorrectGuessesNum = 0;
        incorrectGuessesMaximum = 6;
        lettersGuessed = [];
        guessedWord = false;
        playerScore = 0;
        terms = {};

        % display user options for possible difficulties 
        pause(0.5)
        disp("Difficulty options: Easy, Intermediate, Hard or Pro")
        
        difficultyInputCheck = false;

        % get user input for difficulty
        while ~difficultyInputCheck
            % user input for game difficulty
            gameDifficulty = upper(input("Select a difficulty level: ", 's'));
            fprintf("\n")

            % check user input is one of the difficulty options
            if ismember(gameDifficulty, {'EASY', 'INTERMEDIATE', 'HARD', 'PRO'})
                difficultyInputCheck = true; 
            else 
                % ELSE display error message and ask for a valid input
                disp("ERROR: Please enter one of the difficulty options")
            end
        end

        % depending on which difficulty user chooses, set amount of lives
        switch gameDifficulty
            case 'EASY' % if easy, user gets 7 lives and vice versa
                incorrectGuessesMaximum = 7;
            case 'INTERMEDIATE'
                incorrectGuessesMaximum = 6;
            case 'HARD'
                incorrectGuessesMaximum = 4;
            case 'PRO'
                incorrectGuessesMaximum = 3;
        end 
        
        % initialise to false
        categoryInputCheck = false;

        % display possible categories to the user
        disp("Word Category options: Sports, Animals, Instruments, Fruits, Countries, Colours, Random")
        while ~categoryInputCheck
            % user input for game category
            gameCategory = upper(input("Select a game category: ", 's'));
            fprintf("\n")

            % check if user has entered one of the given categories
            if ismember(gameCategory, {'SPORTS', 'ANIMALS', 'INSTRUMENTS', 'FRUITS', 'COUNTRIES', 'COLOURS', 'RANDOM'})
                categoryInputCheck = true;
            else 
                % ELSE display error message and ask for category input again
                disp("ERROR: Please enter one of the listed game categories")
            end 
        end

        % depending on choosen category, set game topic
        switch gameCategory
            case 'SPORTS' % define terms (or according to the category
                terms = {'CRICKET', 'SOCCER', 'HOCKEY', 'FOOTBALL', 'BADMINTON', 'RUGBY', 'SQUASH', 'WRESTLING', 'BASEBALL', 'BOWLING'}; 
            case 'ANIMALS'
                terms = {'ORANGUTAN', 'BISON', 'ELEPHANT', 'CHIMPANZEE', 'POSSUM', 'RACCON', 'EEL', 'JELLYFISH', 'OWL', 'FALCON'};
            case 'INSTRUMENTS'
                terms = {'PIANO', 'GUITAR', 'VIOLIN', 'FLUTE', 'TRUMPET', 'CELLO', 'MARACAS', 'XYLOPHONE', 'BANJO', 'TUBA'};
            case 'FRUITS'
                terms = {'BLUEBERRY', 'CHERRY', 'PLUM', 'GRAPEFRUIT', 'BOYSENBERRY', 'AMLA', 'TANGERINE', 'KIWI', 'ORANGE', 'FIG'};
            case 'COUNTRIES'
                terms = {'AUSTRALIA', 'HUNGARY', 'IRELAND', 'FRANCE', 'SINGAPORE', 'VANUATU', 'LUXEMBOURG', 'DENMARK', 'ETHIOPIA', 'SWEDEN'};
            case 'COLOURS'
                terms = {'BLUE', 'VIOLET', 'AQUAMARINE', 'MAGNETA', 'GREEN', 'MAROON', 'BRONZE', 'LIME', 'CRIMSON', 'TURQUOISE'};
            case 'RANDOM'
                terms = readlines('random.txt'); % reads a text file with random words defined inside 
        end 
                
        % choosing a random word from the chosen category
        wordSelection = terms{randi(length(terms))};
        
        % start game message
        disp("Alright! Let's Start")
        pause(0.5)

        % countdown to start of game
        for count = 3:-1:1
            disp(count)
            pause(1.0)
        end 

        % message to user to start guessing
        fprintf('You have %d lives! GUESS THE WORD! The word is hidden and comes like this format:', incorrectGuessesMaximum)

        % loop is executed until the word is guessed or user runs out of
        % lives
        while ~guessedWord && incorrectGuessesNum < incorrectGuessesMaximum
           
            % display hangman figure based on incorrect guesses 
            dispHangmanFigure(incorrectGuessesNum, incorrectGuessesMaximum);
            
            % display guessed letters revealed and unguessed letters as
            % underscores 
            dispWordGuessed(wordSelection, lettersGuessed);

            % validate the user's guess
            userGuess = validateUserGuess(lettersGuessed);

            if ~letterExistanceCheck(userGuess, wordSelection)
                % incremenet the count of incorrect guesses when the wrong
                % letter is entered
                incorrectGuessesNum = incorrectGuessesNum + 1;
                
                % display the user a message if the letter is incorrect and show number of
                % lives remaining
                fprintf("OH NO! That's Incorrect! Enter another letter. You have %d lives remaining!", incorrectGuessesMaximum - incorrectGuessesNum)
                fprintf("\n")
            end 
            
            % concatenate the user's guessed letter input to the guessed
            % letters array 
            lettersGuessed = [lettersGuessed, userGuess];
            
            % see if all letters of word to be guessed are in the guessed 
            % letters array 
            if all(ismember(wordSelection, lettersGuessed))
                guessedWord = true; % if all letters guessed, set guessWord to true
            end 
        end 

        % display hangman figure corresponding to the amount of incorrect
        % guesses 
        % letters which have been guessed, should be seen in the word
        % the unguessed letters shown as underscores
        dispHangmanFigure(incorrectGuessesNum, incorrectGuessesMaximum);
        dispWordGuessed(wordSelection, lettersGuessed);

        % user score and game (or round) end
        if guessedWord
            % calculate score
            playerScore = incorrectGuessesMaximum - incorrectGuessesNum;

            % display player score if successful in guessing the entire
            % word
            disp (['Wow! Congratulations! You guessed the word! your final score was ', num2str(playerScore)]);
        else
            % display the rest or entire word if user is unsuccessful in
            % guessing
            disp(['Oh Bad Luck! You ran out of lives, good try. The word was ', wordSelection]);
        end 

        % ask if user wants to play again
        newRound = '';
        while ~strcmpi(newRound, 'Yes') && ~strcmpi(newRound, 'No')
            newRound = input(['Would you like to play again, ', nameUser, ' (yes/no): '], 's');
            fprintf("\n")
            if ~strcmpi(newRound, 'Yes') && ~strcmpi(newRound, 'No')
                disp("ERROR: Please enter a valid answer, either Yes or No")
            end
        end 

        % IF NO, the game ends and the user is shown the exit message
        if strcmpi(newRound, 'No')
            play = false;
            fprintf("Thank you for playing %s", nameUser)
            fprintf("\n")

        % IF YES, the game restarts and the user is shown a new game
        % message
        elseif strcmpi(newRound, 'Yes')
            fprintf("\n")
            disp("--- NEW GAME ---")
            fprintf("\n")
        end 
    end 
end 