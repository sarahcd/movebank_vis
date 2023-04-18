close all
netcdf_path = '/Users/madelinescyphers/Documents/projs_.nosync/movebank_vis/data/user_datasets/eagle_ds_2004_thinned2.nc';
quivers = Quivers(netcdf_path, 'latvar', 'latitude', 'lonvar', 'longitude', 'timevar', 'time', 'u_var', 'u10', 'v_var', 'v10');

fig = figure;

m_proj('lambert','lon',[quivers.minlon,quivers.maxlon],'lat', [quivers.minlat,quivers.maxlat]);


hold on

for timeidx = 1:length(quivers.time_index)

    [quiver_lat, quiver_long, quiver_time, quiver_u] = unpack_netcdf( ...
        quivers.filename, ...
        quivers.latvar, ...
        quivers.lonvar, ...
        quivers.timevar, ...
        quivers.u_var, ...
        start=timeidx, count=1);
    % unpack v data
    [quiver_lat, quiver_long, quiver_time, quiver_v] = unpack_netcdf( ...
            quivers.filename, ...
            quivers.latvar, ...
            quivers.lonvar, ...
            quivers.timevar, ...
            quivers.v_var, ...
            start=timeidx, count=1);

    quivers.move_particles(quiver_u, quiver_v);
    quivers.plot();
% 
    drawnow;

%     delete(quivers.quiverh);
%    
    title(string(quivers.time_index(timeidx)));

end