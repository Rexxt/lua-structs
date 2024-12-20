local struct = require "struct"

foreach = function(table, func)
    for k, v in pairs(table) do
        func(k, v)
    end
end

local Point = struct {
    x = "number",
    y = "number",
}
print(Point)

local A = Point {
    x = 0,
    y = 5,
}
print(A)
print("A(" .. A.x .. ", " .. A.y .. ")")

local B = Point {
    x = 5,
    y = 0,
}
print(B)
print("B(" .. B.x .. ", " .. B.y .. ")")

local Vector = struct {
    A = Point,
    B = Point,
}

local U = Vector {
    A = A,
    B = B,
}
print(U)
print("U(" .. B.x - A.x .. ", " .. B.y - A.y .. ")")

local function norm(U)
    return math.sqrt((U.B.x - U.A.x)^2 + (U.B.y - U.A.y)^2)
end

print(norm(U))