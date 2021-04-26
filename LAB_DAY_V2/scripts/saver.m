function saver(fileName,out)
    i = 0;
    while isfile(strcat(fileName,string(i),'.mat'))
        i = i+1;
    end
    fileNameComplete = strcat(fileName,string(i),'.mat');
    save(fileNameComplete,'out');
end