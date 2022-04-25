# Declare this file as a StarkNet contract.
%lang starknet

from starkware.cairo.common.math import assert_not_zero, assert_not_equal, assert_in_range
from starkware.cairo.common.cairo_builtins import HashBuiltin

# Metric that is basis for allocation
@storage_var
func metric(index : felt) -> (value : felt):
end

@storage_var
func metrics_len() -> (value : felt):
end

# Push a new metric into the history array
@external
func push_metric{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}(index : felt, value : felt):
    let (count) = metrics_len.read()
    assert index = count
    metric.write(index, value)
    metrics_len.write(index + 1)
    return ()
end

func sum_metrics{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}(index) -> (sum):
    if index == 0:
        let (value) = metric.read(0)
        return (sum=value)
    end

    let (sum_of_rest) = sum_metrics(index - 1)
    let (value) = metric.read(0)
    return (sum=value + sum_of_rest)
end

# Returns the allocation(s) based on the metrics history
@view
func get_allocation{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}() -> (allocation : felt):
    let (count) = metrics_len.read()
    if count == 0:
        return (allocation=0)
    end
    let (sum) = sum_metrics(count - 1)
    return (allocation=sum)
end

@view
func get_count{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}() -> (count : felt):
    let (count) = metrics_len.read()
    return (count=count)
end