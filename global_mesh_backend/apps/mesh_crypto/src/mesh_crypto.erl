-module(mesh_crypto).
-export([generate_lockdown_jwt/1]).
-on_load(init/0).

init() ->
    %% Dynamically load the compiled Rust .so/.dll binary into the BEAM memory space
    PrivDir = code:priv_dir(mesh_crypto),
    SoName = filename:join([PrivDir, "libmesh_crypto"]),
    erlang:load_nif(SoName, 0).

generate_lockdown_jwt(_DevId) ->
    %% This function is overridden by the Rust code upon successful load.
    %% If you see this error, the Rust bridge failed to connect.
    erlang:nif_error("NIF library not loaded").
