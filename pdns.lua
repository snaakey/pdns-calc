; expr = qname:makeRelative(newDN('calc.cyfn.de.'))
function splitTokens(s)
    local tokens = {}
    for i in string.gmatch(s, '%w+') do 
        table.insert(tokens, i) 
    end
    return tokens
end
PLUS = 'a'
MINUS = 's'
TIMES = 'm'
DIVIDE = 'd'
function isDash(token)
    return token == PLUS or token == MINUS
end
function isDot(token)
    return token == TIMES or token == DIVIDE
end
function parseNum(tokens)
    local val = table.remove(tokens, 1)
    val = tonumber(val)
    return {
        ['type'] = 'num',
        ['num'] = val
    }
end
function parseFactor(tokens)
    local lhs = parseNum(tokens)
    while isDot(tokens[1]) do
        local op = table.remove(tokens, 1)
        local rhs = parseNum(tokens)
        lhs = {
            ['type'] = 'op',
            ['op'] = op,
            ['lhs'] = lhs,
            ['rhs'] = rhs
        }
    end
    return lhs
end
function parseTerm(tokens)
    local lhs = parseFactor(tokens)
    while isDash(tokens[1]) do
        local op = table.remove(tokens, 1)
        local rhs = parseFactor(tokens)
        lhs = {
            ['type'] = 'op',
            ['op'] = op,
            ['lhs'] = lhs,
            ['rhs'] = rhs,
        }
    end
    return lhs
end
function parseExpr(tokens)
    return parseTerm(tokens)
end
function eval(expr)
    if expr['type'] == 'num' then
        return expr['num']
    elseif expr['type'] == 'op' then
        local lval = eval(expr['lhs'])
        local rval = eval(expr['rhs'])
        if expr['op'] == PLUS then
            return lval + rval
        elseif expr['op'] == MINUS then
            return lval - rval
        elseif expr['op'] == TIMES then
            return lval * rval
        elseif expr['op'] == DIVIDE then
            return lval / rval
        else
            print('invalid operator!')
        end
    else
        print('invalid expr type!')
    end
end
return eval(parseExpr(splitTokens(expr:toStringNoDot())))
