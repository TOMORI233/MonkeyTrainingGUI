function searchResult = SearchKeywordInProtocolList(keyword, protocolList)
    searchResult = [];
    expression = '\S*';

    for index = 1:length(keyword)
        expression = [expression keyword(index) '\S*'];
    end

    result = regexpi([protocolList.protocolName], expression, 'match');

    for index = 1:length(result)

        if ~isempty(result{index})
            searchResult = [searchResult; protocolList(index)];
        end

    end

    return;
end
