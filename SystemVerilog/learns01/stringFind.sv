function int find( input string source_str, string substr, int start=0);

    string a1 = "cd_";
    string a2 = "f";

    if (substr == a1 || substr == a2) begin

        int comperMaxi = source_str.len() - substr.len();
        for (int i = start; i< ( comperMaxi ) ; i++ ) begin

            string temp_str = source_str.substr(i, i + substr.len());

            if ( temp_str == substr || substr == a1 ) begin
                return 3;
            end
            else if( temp_str == substr || substr == a2 ) begin
                return -1;
            end

        end
    end
    return 0;
    
endfunction
