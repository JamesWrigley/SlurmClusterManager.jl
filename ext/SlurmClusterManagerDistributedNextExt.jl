module SlurmClusterManagerDistributedNextExt

import DistributedNext
import SlurmClusterManager
using SlurmClusterManager: SlurmManager

# SlurmManager subtypes `Distributed.ClusterManager`, not
# `DistributedNext.ClusterManager`. DistributedNext recognises external
# managers via the `is_cluster_manager` trait, which we opt into here.
DistributedNext.is_cluster_manager(::SlurmManager) = true

function DistributedNext.launch(manager::SlurmManager, params::Dict, instances_arr::Array, c::Condition)
    SlurmClusterManager._launch_impl(:DistributedNext, manager, params, instances_arr, c)
end

function DistributedNext.manage(manager::SlurmManager, id::Integer, config::DistributedNext.WorkerConfig, op::Symbol)
    # This function needs to exist, but so far we don't do anything
end

SlurmClusterManager.backend_default_addprocs_params(::Val{:DistributedNext}) = DistributedNext.default_addprocs_params()
SlurmClusterManager.backend_worker_arg(::Val{:DistributedNext}) = DistributedNext.get_worker_arg()
SlurmClusterManager.backend_cluster_cookie(::Val{:DistributedNext}) = DistributedNext.cluster_cookie()
SlurmClusterManager.backend_worker_config(::Val{:DistributedNext}) = DistributedNext.WorkerConfig()

end # module
