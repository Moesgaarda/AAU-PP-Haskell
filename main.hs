import Data.List (sortOn)

type Symbol = Char
type Weight = Int

data Tree = Leaf Char Int
            | Branch Tree Tree [Symbol] Weight
                deriving (Show)
            -- Subtree has a [Symbol] so that we can
            -- Do a full pattern matching in getSymbol,
            -- However, it'll always be an empty [].

countLetters :: [Symbol] -> [Tree]
countLetters [] = []
countLetters inputString = makeLeaf (sortOn snd [(x, y) | x<-[' '..'z'], let y = (length.filter (==x)) inputString, y>0])
    -- sortOn fra data.List hvor snd er andet element i tuplen
    -- x er en liste af alle bogstaver den skal genkende (0-9, A-z)
    -- for hvert bogstav, tjek hvor mange gange det opstår
    -- Filtrer alle der ikke er der mindst 1 gang

makeLeaf :: [(Char, Int)] -> [Tree]
makeLeaf [] = []
makeLeaf (x:xs) = Leaf (fst x) (snd x) : makeLeaf xs

makeBranch :: Tree -> Tree -> Tree
makeBranch left right       = Branch left right
                                ((getSymbol left) ++ (getSymbol right))
                                ((getWeight left) + (getWeight right))

getWeight :: Tree -> Weight
getWeight (Leaf _ w) = w
getWeight (Branch _ _ _ w) = w

getSymbol :: Tree -> [Symbol]
getSymbol (Leaf s _) = [s]
getSymbol (Branch _ _ s _) = s

sortedInsert :: Tree -> [Tree] -> [Tree]
sortedInsert n [] = [n]
sortedInsert n (y:ys) = if (getWeight n) <= (getWeight y)
                        then n:y:ys
                        else y: sortedInsert n ys

makeEncodingTree :: [Tree] -> Tree
makeEncodingTree [n] = n
makeEncodingTree (left:right:rest) =
    let branch = makeBranch left right
    in makeEncodingTree (sortedInsert branch rest)

encode :: [Symbol] -> Tree -> [Int]
encode [] _ = []
encode symbol tree = encode' tree tree symbol -- Call a helper method that takes tree

encode' :: Tree -> Tree -> [Symbol] -> [Int]
encode' _ _ [] = []
encode' encodingTree (Leaf _ _) (x:xs) = encode' encodingTree encodingTree xs
encode' encodingTree (Branch left right _ _) (x:xs) =
        if elem x (getSymbol left)  then    0 : encode' encodingTree left (x:xs) -- If x exists in first branch, go there and send current and next letters along
        else                                1 : encode' encodingTree right (x:xs) -- otherwise go to the other branch

decode :: [Int] -> Tree -> [Symbol]
decode [] _ = []
decode symbol tree = decode' tree tree symbol

decode' :: Tree -> Tree -> [Int] -> [Symbol]
decode' decodingTree (Leaf symbol _ ) path  = symbol : decode' decodingTree decodingTree path
decode' decodingTree (Branch left right _ _) (bit:path)  =
        if (bit == 0) then  decode' decodingTree left path
        else                decode' decodingTree right path
decode' _ _ [] = []
