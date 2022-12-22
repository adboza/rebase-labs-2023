require 'csv'
require 'pg'

class ImportFromCsv
  attr_reader :connection

  def initialize
    @connection = PG.connect(host: 'postgres', dbname: 'postgres', user: 'postgres')
    create_table
    insert_data
    @connection.close
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
    CSV.read('./data.csv', headers: true, col_sep: ';') do |row|
      
      @connection.exec_params(
        "INSERT INTO EXAMS (cpf, nome_paciente, email_paciente, data_nascimento_paciente, 
          endereço_rua_paciente, cidade_paciente, estado_patiente, crm_médico,
          crm_médico_estado, nome_médico, email_médico, token_resultado_exame,
          data_exame, tipo_exame, limites_tipo_exame, resultado_tipo_exame)
          VALUES ('#{row[0]}', '#{row[1]}', '#{row[2]}', '#{row[3]}', '#{row[4]}',
                  '#{row[5]}', '#{row[6]}', '#{row[7]}', '#{row[8]}', '#{row[9]}', '#{row[10]}',
                  '#{row[11]}', '#{row[12]}', '#{row[13]}', '#{row[14]}', '#{row[15]}')"
      )
      p "#{row[0]}, "
    end
  end
end