import Data.List (sortOn)

type Symbol = Char
type Weight = Int

data Tree = Leaf Char Int
            | Branch Tree Tree [Symbol] Weight
                deriving (Show)
            -- Subtree has a [Symbol] so that we can
            -- Do a full pattern matching in getSymbol,
            -- However, it'll always be an empty [].

count :: [Symbol] -> [Tree]
count [] = []
count inputString = makeLeaf (sortOn snd [(x, y) | x<-[' '..'z'], let y = (length.filter (==x)) inputString, y>0])
    -- sortOn fra data.List hvor snd er andet element i tuplen
    -- x er en liste af alle bogstaver den skal genkende (0-9, A-z)
    -- for hvert bogstav, tjek hvor mange gange det opstår
    -- Filtrer alle der ikke er der mindst 1 gang

makeLeaf :: [(Char, Int)] -> [Tree]
makeLeaf [] = []
makeLeaf (x:xs) = (Leaf (fst x) (snd x)) : makeLeaf xs

getWeight :: Tree -> Weight
getWeight (Leaf _ w) = w
getWeight (Branch _ _ _ w) = w

getSymbol :: Tree -> [Symbol]
getSymbol (Leaf s _) = [s]
getSymbol (Branch _ _ s _) = s

insertToTree :: Tree -> [Tree] -> [Tree]
insertToTree n [] = [n]
insertToTree n (y:ys) =  if (getWeight n) <= (getWeight y)
                    then n:y:ys
                    else y: insertToTree n ys
-- Tjek om vægten på den nuværende er den laveste sæt ind
-- ellers kør igen på første element i xs som burde være den laveste i listen

-- choose the two with lowest number, merge them to new branch
-- releat until only one largest?


makeTree :: [Tree] -> Tree
makeTree [n] = n
makeTree (first:second:rest) =
    let n = Branch
                first
                second
                ((getSymbol first) ++ (getSymbol second))
                ((getWeight first) + (getWeight second))
            in
        makeTree (insertToTree n rest)
