function out = read_images(path)
  %in order to add strings we need to use cell array instead of list
  file_names = {};
  contents = dir(path);

  %number of subfiles and folders
  n = size(contents);

  for i = 1:n(1)
    if ~contents(i).isdir
      file_names{end + 1} = contents(i).name;
    end
  end
  
  out = file_names;
end