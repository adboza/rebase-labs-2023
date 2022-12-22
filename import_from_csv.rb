require 'csv'
require 'pg'

class ImportFromCsv
  attr_reader :connection

  def initialize
    @connection = PG.connect(host: 'postgres', dbname: 'postgres', user: 'postgres')
    create_table
    insert_data
  end

  def create_table
    @connection.exec("DROP TABLE EXAMS")
    @connection.exec("
        CREATE TABLE EXAMS(
          id SERIAL PRIMARY KEY,
          cpf VARCHAR(14),
          nome_paciente VARCHAR(140),
          email_paciente VARCHAR(120),
          data_nascimento_paciente DATE,
          endereço_rua_paciente VARCHAR(140),
          cidade_paciente VARCHAR(55),
          estado_patiente VARCHAR(35),
          crm_médico VARCHAR(11),
          crm_médico_estado VARCHAR(2),
          nome_médico VARCHAR(140),
          email_médico VARCHAR(120),
          token_resultado_exame VARCHAR(10),
          data_exame DATE,
          tipo_exame VARCHAR(50),
          limites_tipo_exame VARCHAR(10),
          resultado_tipo_exame INTEGER
        )
    ")
  end

  def insert_data
    puts '$$$$$$$$$$$$$$$$$$ inside import_from_csv.rb line 39, '
  
    csv_iteration.each do |row|
      @connection.exec(
        "INSERT INTO EXAMS (cpf, nome_paciente, email_paciente, data_nascimento_paciente, 
          endereço_rua_paciente, cidade_paciente, estado_patiente, crm_médico,
          crm_médico_estado, nome_médico, email_médico, token_resultado_exame,
          data_exame, tipo_exame, limites_tipo_exame, resultado_tipo_exame)
          VALUES ('#{row['cpf']}', '#{row['nome paciente']}', '#{row['email paciente']}', '#{row['data nascimento paciente']}', '#{row['endereço/rua paciente']}',
                  '#{@connection.escape_string(row['cidade paciente'])}', '#{row['estado patiente']}',
                  '#{row['crm médico']}', '#{row['crm médico estado']}',
                  '#{row['nome médico']}', '#{row['email médico']}',
                  '#{row['token resultado exame']}', '#{row['data exame']}',
                  '#{row['tipo exame']}', '#{row['limites tipo exame']}', #{row['resultado tipo_exame'].to_i})"
      )
    end
    puts '$$$$$$$$$$$$$$$$$$ inside import_from_csv.rb line 55, end of insert into exams'
    puts @connection.exec("SELECT * FROM EXAMS")

  end

  def csv_iteration
    rows = CSV.read("./data.csv", col_sep: ';')

    columns = rows.shift

    rows.map do |row|
      row.each_with_object({}).with_index do |(cell, acc), idx|
        column = columns[idx]
        acc[column] = cell
      end
    end
  end
end