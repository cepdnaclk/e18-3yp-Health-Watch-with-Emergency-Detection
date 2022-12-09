import { StatusBar } from 'expo-status-bar';
import { StyleSheet,Text, Button, View } from 'react-native';

export default function HomeScreen({ navigation }) {
  return ( <>
            <View style={styles.container1}>
    <Button 
        title="Log in screen"
        onPress={() => navigation.navigate("Login", { username: "Anne" })}
      />
      <Button 
        title="Navigate to second screen: Anne"
        onPress={() => navigation.navigate("Second", { username: "Anne" })}
      />
      <Button 
        title="Navigate to second screen: David"
        onPress={() => navigation.navigate("Second", { username: "David" })}
      />
      <StatusBar style="auto" />
    </View>
    <View style={styles.container2}></View>
    <View style={styles.container3}>
        <View style={styles.rectangle1}>
            <Text>Oxygen level of blood</Text>
        </View>
        <View style={styles.rectangle1}>
            <Text>Temperature</Text>
        </View>
        <View style={styles.rectangle1}></View>
    </View>
  </>
    
  );
}

const styles = StyleSheet.create({
  container1: {
    flex: 2,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
  container2: {
    flex: 2,
    backgroundColor: '#33bbff',
    alignItems: 'center',
    justifyContent: 'center',
  },
  container3: {
    flex: 5,
    backgroundColor: '#146188',
    alignItems: 'center',
    justifyContent: 'center',
  },
  rectangle1: {
    
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
    width:300,
    height:75,
    margin:4,
    borderRadius:10
  },

});