-- Livro mais antigo
SELECT titulo, ano_publicacao 
FROM livros 
WHERE ano_publicacao = (SELECT MIN(ano_publicacao) FROM livros)

UNION

-- Livro mais recente
SELECT titulo, ano_publicacao 
FROM livros 
WHERE ano_publicacao = (SELECT MAX(ano_publicacao) FROM livros);