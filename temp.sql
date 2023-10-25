open = {START}, closed = Ø
while (open ≠ Ø)
    X ← remove first state from open 
    if (X is Goal) return (Solution)
    else
        generate children of X 
        put X into closed 
        eliminate child if it is in open or closed 
        put remaining children into left of open(stack)
return (fail)