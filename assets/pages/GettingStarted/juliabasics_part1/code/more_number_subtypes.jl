# This file was generated, do not modify it. # hide
using InteractiveUtils # hide
for type in subtypes(Number)
    # First get the subtypes
    subs = subtypes(type)
    # Now iterate through them and print them nicely
    println("subtypes($type):")
    for sub in subs
        println("|--> $sub")
    end
    println()
end