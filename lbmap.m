function map = lbmap(n,scheme)

%valid schemes
switch lower(scheme)
  case 'redwhiteblue'
    baseMap = RedWhiteBlueMap;
  otherwise
    error(['Invalid scheme ' scheme])
end
idx1 = linspace(0,1,size(baseMap,1));
idx2 = linspace(0,1,n);
map = interp1(idx1,baseMap,idx2);

function baseMap = RedWhiteBlueMap
baseMap = [175  53  71;
           216  82  88;
           239 133 122;
           245 177 139;
           %249 216 168;
           255 255 255;
           %216 236 241;
           154 217 238;
            68 199 239;
             0 170 226;
             0 116 188]/255;
