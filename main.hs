type Symbol = Char
type Weight = Int

count :: [Symbol] -> [(Symbol, Weight)]
count [] = []
count inputString = [(x, y) | x<-['0'..'z'], let y = (length.filter (==x)) inputString, y>0]

-- x er en liste af alle bogstaver den skal genkende (0-9, A-z)
-- for hvert bogstav, tjek hvor mange gange det opstår
-- Filtrer alle der ikke er der mindst 1 gang

data Node = Leaf Symbol Weight
            | Subtree Node Node [Symbol] Weight

getWeight :: Node -> Weight
getWeight (Leaf _ w) = w
getWeight (Subtree _ _ _ w) = w

getSymbol :: Node -> [Symbol]
getSymbol (Leaf s _) = [s]
getSymbol (Subtree _ _ s _) = s
