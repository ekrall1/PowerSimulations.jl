abstract type AbstractOperationsModel end

abstract type EconomicDispatch <: AbstractOperationsModel end

abstract type UnitCommitment <: AbstractOperationsModel end

abstract type CustomModel <: AbstractOperationsModel end

mutable struct PowerOperationModel{ M<:AbstractOperationsModel, T<:NetworkModel}
    psmodel::Type{M}
    generation::Array{NamedTuple{(:device, :formulation), Tuple{DataType,DataType}}}
    demand::Array{NamedTuple{(:device, :formulation), Tuple{DataType,DataType}}}
    storage::Union{Nothing,Array{NamedTuple{(:device, :formulation), Tuple{DataType,DataType}}}}
    branches::Array{NamedTuple{(:device, :formulation), Tuple{DataType,DataType}}}
    transmission::Type{T}
    services::Array{DataType} #TODO: make this explicitly required to be a type of AbstractServiceForm or nothing
    system::PowerSystems.PowerSystem
    model::JuMP.Model
    dynamics::Bool
end

mutable struct PowerSimulationsModel{T<:AbstractOperationsModel}
    name::String
    model::PowerOperationModel{T}
    periods::Int64
    resolution::Int64
    date_from::DateTime
    date_to::DateTime
    lookahead_periods::Int64
    lookahead_resolution::Int64
    dynamic_analysis::Bool
    timeseries::Any
end

 mutable struct PowerResults
    ThermalGeneration::Union{Nothing,DataFrame}
    RenewableGEneration::Union{Nothing,DataFrame}
    HydroGeneration::Union{Nothing,DataFrame}
    Storage::Union{Nothing,DataFrame}
    Load::Union{Nothing,DataFrame}
    SolverOutput::Union{Nothing,Dict}
end
