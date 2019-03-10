using Test
using ChipSort
using SIMD

data = rand(256)
@test chipsort(data,Val(8),Val(8),Val(8)) == sort(data)

data = rand(256)
@test chipsort_medium(data,Val(8),Val(8)) == sort(data)

data = tuple((Vec(tuple(sort(rand(Int8,4))...)) for _ in 1:4)...)
stream_to_array(data) = [k[i] for i in 1:length(data), k in data][:]
@test stream_to_array(merge_vecs_tree(data...)) == sort(stream_to_array(data))
