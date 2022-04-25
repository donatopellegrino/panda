%builtins range_check

func div2(x):
    %{ memory[ap] = ids.x % 2 %}
    jmp odd if [ap] != 0; ap++

    even:
    # Case n % 2 == 0.
    [ap] = x / 2; ap++
    ret

    odd:
    # Case n % 2 == 1.
    [ap] = x - 1; ap++
    [ap] = [ap - 1] / 2; ap++
    ret
end

func main{range_check_ptr}():
    [ap] = 1001; ap++
    div2([ap - 1])
    [ap] = [range_check_ptr]
    ret
end