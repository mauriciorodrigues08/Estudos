# Define o compilador
COBC = cobc

# Define as flags
FLAGS = -x

# Define a pasta onde estao os codigos
SRC_DIR = src

# Aponta o executavel e os arquivos para dentro da pasta src
TARGET = $(SRC_DIR)/exe
MAIN = $(SRC_DIR)/Main.cbl
MODULES = $(SRC_DIR)/CRUD.cbl $(SRC_DIR)/ImportaCsv.cbl $(SRC_DIR)/ProcessarVendas.cbl $(SRC_DIR)/RealizarVenda.cbl 

# Regra padrao
all: $(TARGET)

# Compilacao juntando os arquivos da pasta src
$(TARGET): $(MAIN) $(MODULES)
	$(COBC) $(FLAGS) $(MAIN) $(MODULES) -o $(TARGET)
	@echo "Compilacao concluida! Executavel gerado em '$(TARGET)'."

# Regra para limpar a pasta src
clean:
	rm -f $(TARGET)
	@echo "Executavel removido."

# Regra para compilar e rodar
run: $(TARGET)
	cd $(SRC_DIR) && ./exe
