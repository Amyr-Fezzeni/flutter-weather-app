enum LanguageModel { french, english }

getLanguageFromString(String value) =>
    {'english': LanguageModel.english}[value] ?? LanguageModel.french;
