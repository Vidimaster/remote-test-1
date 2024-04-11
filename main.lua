local vectors = require(g3d.path .. ".vectors")
local fastSubtract = vectors.subtract
local vectorAdd = vectors.add
local vectorCrossProduct = vectors.crossProduct
local vectorDotProduct = vectors.dotProduct
local vectorNormalize = vectors.normalize
local vectorMagnitude = vectors.magnitude

local collisions = {}

local function closestPointOnLineSegment(
        a_x,a_y,a_z, -- point one of line segment
        b_x,b_y,b_z, -- point two of line segment
        x,y,z        -- source point
    )
    local ab_x, ab_y, ab_z = b_x - a_x, b_y - a_y, b_z - a_z
    local t = vectorDotProduct(x - a_x, y - a_y, z - a_z, ab_x, ab_y, ab_z) / (ab_x^2 + ab_y^2 + ab_z^2)
    t = math.min(1, math.max(0, t))
    return a_x + t*ab_x, a_y + t*ab_y, a_z + t*ab_z
end


function collisions.rayIntersection(verts, transform, src_x, src_y, src_z, dir_x, dir_y, dir_z)
    return findClosest(transform, verts, triangleRay, src_x, src_y, src_z, dir_x, dir_y, dir_z)
end

function collisions.isPointInside(verts, transform, x, y, z)
    return findAny(transform, verts, triangleRay, x, y, z, 0, 0, 1)
end

function collisions.sphereIntersection(verts, transform, src_x, src_y, src_z, radius)
    return findClosest(transform, verts, triangleSphere, src_x, src_y, src_z, radius)
end

function collisions.closestPoint(verts, transform, src_x, src_y, src_z)
    return findClosest(transform, verts, trianglePoint, src_x, src_y, src_z)
end

