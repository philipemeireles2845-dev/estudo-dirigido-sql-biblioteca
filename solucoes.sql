-- 1. SELECT Simples: Selecionar todos os títulos dos livros e seus respectivos anos de publicação.

SELECT titulo, ano_publicacao FROM livros;

-- 2. COUNT: Quantos livros foram publicados?

SELECT COUNT(*) AS total_livros FROM livros;

-- 3. AVERAGE e GROUP BY: Calcule a média do ano de publicação dos livros para cada editora. Exiba o nome da editora e a média do ano de publicação.

SELECT e.nome AS editora, AVG(l.ano_publicacao) AS media_ano FROM livros l JOIN editoras e ON l.editora_id = e.editora_id GROUP BY e.editora_id, e.nome;

-- 4. MAX e MIN: Qual é o livro mais antigo e o mais recente no acervo? Exiba o título e o ano de publicação para ambos.

-- Livro mais antigo
SELECT titulo, ano_publicacao 
FROM livros 
WHERE ano_publicacao = (SELECT MIN(ano_publicacao) FROM livros)

UNION

-- Livro mais recente
SELECT titulo, ano_publicacao 
FROM livros 
WHERE ano_publicacao = (SELECT MAX(ano_publicacao) FROM livros);

-- 5. WHERE: Liste todos os livros publicados após o ano 2000.

SELECT titulo, ano_publicacao 
FROM livros 
WHERE ano_publicacao > 2000;

-- 6. ORDER BY: Selecione todos os autores e ordene-os em ordem alfabética crescente pelo nome.

SELECT nome, nacionalidade 
FROM autores 
ORDER BY nome ASC;

-- 7. HAVING: Liste as editoras que publicaram mais de 2 livros.

SELECT e.nome AS editora, COUNT(l.livro_id) AS total_livros
FROM editoras e
LEFT JOIN livros l ON e.editora_id = l.editora_id
GROUP BY e.editora_id, e.nome
HAVING COUNT(l.livro_id) > 2;

-- 8. CASE: Crie uma query que liste o título do livro e uma coluna Status que indique 'Disponível' se o livro não tiver data_devolucao preenchida nos empréstimos, ou 'Emprestado' caso contrário.

SELECT l.titulo,
       CASE 
           WHEN e.data_devolucao IS NULL AND e.emprestimo_id IS NOT NULL THEN 'Emprestado'
           ELSE 'Disponível'
       END AS status
FROM livros l
LEFT JOIN emprestimos e ON l.livro_id = e.livro_id AND e.data_devolucao IS NULL;

-- 9. JOIN (INNER JOIN): Liste o título de todos os livros juntamente com o nome do autor e o nome da editora.

SELECT l.titulo, a.nome AS autor, e.nome AS editora
FROM livros l
INNER JOIN autores a ON l.autor_id = a.autor_id
INNER JOIN editoras e ON l.editora_id = e.editora_id;

-- 10. JOIN (LEFT JOIN) e WHERE: Encontre todos os livros que não possuem um autor cadastrado. Exiba o título do livro.

SELECT l.titulo
FROM livros l
LEFT JOIN autores a ON l.autor_id = a.autor_id
WHERE l.autor_id IS NULL;