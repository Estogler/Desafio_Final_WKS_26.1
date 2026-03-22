CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    endereco VARCHAR(150),
    telefone VARCHAR(20),
    email VARCHAR(100),
    data_cadastro DATE
);

CREATE TABLE funcionario (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    cargo VARCHAR(50),
    telefone VARCHAR(20),
    email VARCHAR(100),
    data_admissao DATE
);

CREATE TABLE veiculo (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(10) UNIQUE NOT NULL,
    modelo VARCHAR(50),
    marca VARCHAR(50),
    ano INT,
    valor_diaria DECIMAL(10,2),
    status VARCHAR(30)
);

CREATE TABLE aluguel (
    id_aluguel INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_funcionario INT,
    id_veiculo INT,
    data_inicio DATE,
    data_fim DATE,
    valor_total DECIMAL(10,2),
    status VARCHAR(30),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario),
    FOREIGN KEY (id_veiculo) REFERENCES veiculo(id_veiculo)
);

CREATE TABLE pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_aluguel INT,
    valor DECIMAL(10,2),
    data_pagamento DATE,
    metodo VARCHAR(30),
    status VARCHAR(30),
    desconto DECIMAL(10,2),
    juros DECIMAL(10,2),
    comprovante TEXT,
    FOREIGN KEY (id_aluguel) REFERENCES aluguel(id_aluguel)
);

CREATE TABLE manutencao (
    id_manutencao INT AUTO_INCREMENT PRIMARY KEY,
    id_veiculo INT,
    descricao TEXT,
    custo DECIMAL(10,2),
    data DATE,
    tipo VARCHAR(50),
    status VARCHAR(30),
    fornecedor VARCHAR(100),
    FOREIGN KEY (id_veiculo) REFERENCES veiculo(id_veiculo)
);

INSERT INTO cliente (nome, cpf, endereco, telefone, email, data_cadastro) VALUES
('João Silva', '123.456.789-00', 'Rua A', '83999999999', 'joao@email.com', '2024-01-10'),
('Maria Souza', '987.654.321-00', 'Rua B', '83988888888', 'maria@email.com', '2024-02-15');

INSERT INTO veiculo (placa, modelo, marca, ano, valor_diaria, status) VALUES
('ABC1234', 'Onix', 'Chevrolet', 2022, 120.00, 'disponivel'),
('XYZ5678', 'HB20', 'Hyundai', 2023, 130.00, 'alugado');

INSERT INTO funcionario (nome, cpf, cargo, telefone, email, data_admissao) VALUES
('Carlos Lima', '111.222.333-44', 'Atendente', '83977777777', 'carlos@email.com', '2023-05-01');

INSERT INTO aluguel (id_cliente, id_funcionario, id_veiculo, data_inicio, data_fim, valor_total, status) VALUES
(1, 1, 1, '2024-03-01', '2024-03-05', 600.00, 'finalizado');

INSERT INTO pagamento (id_aluguel, valor, data_pagamento, metodo, status, desconto, juros) VALUES
(1, 600.00, '2024-03-01', 'pix', 'concluido', 0, 0);

INSERT INTO manutencao (id_veiculo, descricao, custo, data, tipo, status, fornecedor) VALUES
(1, 'Troca de óleo', 150.00, '2024-02-10', 'preventiva', 'concluido', 'AutoCenter');

UPDATE veiculo
SET status = 'manutencao'
WHERE id_veiculo = 1;

UPDATE pagamento
SET status = 'concluido'
WHERE id_pagamento = 1;

-- Total faturado
SELECT SUM(valor_total) AS total_faturado FROM aluguel;

-- Média diária dos veículos
SELECT AVG(valor_diaria) AS media_diaria FROM veiculo;

-- Quantidade de aluguéis por status
SELECT status, COUNT(*) 
FROM aluguel
GROUP BY status;

-- Total por método de pagamento
SELECT metodo, SUM(valor)
FROM pagamento
GROUP BY metodo;

SELECT c.nome, v.modelo, a.data_inicio
FROM aluguel a
INNER JOIN cliente c ON a.id_cliente = c.id_cliente
INNER JOIN veiculo v ON a.id_veiculo = v.id_veiculo;

SELECT v.modelo, m.descricao
FROM veiculo v
LEFT JOIN manutencao m ON v.id_veiculo = m.id_veiculo;

SELECT c.nome, p.valor, p.status
FROM pagamento p
JOIN aluguel a ON p.id_aluguel = a.id_aluguel
JOIN cliente c ON a.id_cliente = c.id_cliente;

