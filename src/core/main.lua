local users = {} -- database
local loggedAs

-- @params:
-- username: string
-- @return: boolean

function existsAccount (username)
    return table.find(users, 
        function (value) 
            return value.username == username
        end
    )
end

-- @params:
-- username: string
-- password: string
-- email: string
-- @return: boolean

function create (username, password, email)
    if (type(username) ~= 'string' and type(password) ~= 'string' and type(email) ~= 'string') then
        return false
    end

    if (existsAccount(username)) then
        print('Esse usuário ja existe.')
    end

    -- insert user account into db
    table.insert(users, {username = username, password = password, email = email})
    
    return true
end

-- @params:
-- username: string
-- password: string
-- @return: user_data

function signIn (username, password)
    if (type(username) ~= 'string' and type(password) ~= 'string') then
        return false
    end

    local existsAccount = existsAccount(username)

    if (not existsAccount) then
        return print('Esse usuário não existe no banco de dados.')
    end

    local account = users[existsAccount]

    if (account.password ~= password) then
        return print("As senhas não coincidem.")
    end

    loggedAs = account.username
    
    return print('Seja Bem Vindo: '..account.username..'.')
end

-- @params:
-- username: string
-- @return: boolean

local function deleteAccount (username)
    if (type(username) ~= 'string') then
        return false
    end

    local existsAccount = existsAccount(username)

    if (not existsAccount) then
        return print('Esse usuário não existe no banco de dados.')
    end

    local account = users[existsAccount]
    
    account = nil

    return true
end

function logout()
    if (not loggedAs) then
        return
    end

    deleteAccount(loggedAs)

    iprint('Usuário: '..loggedAs..' saiu do sistema.')

    loggedAs = nil
end

function getUsers()
    return #users
end