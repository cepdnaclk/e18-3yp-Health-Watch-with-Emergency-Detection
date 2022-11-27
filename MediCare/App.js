import { StatusBar } from 'expo-status-bar';
import { StyleSheet, Text, View, Button, TextInput, ImageBackground } from 'react-native';
import CustomButton from './costomButton';

export default function App() {
  return (
    <View style={styles.appContainer}>
      <ImageBackground source={require('./assets/logo1.png')} style={styles.backgroundImage}/>
      <View style={styles.container}>
        <TextInput style={styles.textInput} placeholder='Username' />
        <TextInput style={styles.textInput} placeholder='Password' />
      </View>
      <View style={styles.buttonContainer}>
        <CustomButton text='Login' onPress={() => alert('Login button pressed')} />
      </View>
      <View style={styles.buttonContainer}>
        <CustomButton text='signup' onPress={() => alert('Register button pressed')} />
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  appContainer: {
    padding: 50,
    alignContent: 'center',
    justifyContent: 'center',
    flex: 1,
  },
  container: {
    flexDirection: 'column',
  },
  textInput: {
    borderColor: 'black',
    borderWidth: 1,
    padding: 8,
    marginBottom: 10,
    borderRadius: 10,
  },
  buttonContainer: {
    marginVertical: 10,
  },
  backgroundImage: {
    flex: 1,
    justifyContent: 'center',
    alignContent: 'center',
    height: '90%',
  }
});
