import keras
from keras.models import Sequential
from keras.layers import Conv2D
from keras.layers import MaxPooling2D
from keras.layers import Flatten
from keras.layers import Dense

model = Sequential()

# Etapa de convolução
model.add(Conv2D(filters=6, kernel_size=5, strides=1, activation='relu', input_shape=(32, 32, 1)))
model.add(MaxPooling2D(pool_size=2, strides=2))
model.add(Conv2D(filters=16, kernel_size=5, strides=1, activation='relu', input_shape=(14, 14, 6)))
model.add(MaxPooling2D(pool_size=2, strides=2))
model.add(Flatten())

# Criação da rede neural
model.add(Dense(units=120, activation='relu'))
model.add(Dense(units=84, activation='relu'))
model.add(Dense(units=10, activation='softmax'))

# Etapa de treinamento
model.compile(optimizer='adam', loss='categorical_crossentropy', metrics=['accuracy'])
model.fit(x_train, y_train, steps_per_epoch=10, epochs=42)

# Etapa de teste
y_pred = model.predict(x_test)

# Salvando os pesos treinados
labels = np.argmax(y_pred, axis=1)
index = np.arange(1, 28001)
labels = labels.reshape([len(labels), 1])
index = index.reshape([len(index), 1])
final = np.concatenate([index, labels], axis=1)
np.savetxt("mnist_1.cvs", final, delimiter=" ", fmt='%s')
