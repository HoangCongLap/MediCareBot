CREATE DATABASE IF NOT EXISTS pharmacy_system;
USE pharmacy_system;

CREATE TABLE IF NOT EXISTS Patient (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    dob DATE,
    gender ENUM('Male', 'Female') NOT NULL,
    address VARCHAR(255)
);
INSERT INTO Patient (name, dob, gender, address)
VALUES 
('Nguyễn Văn A', '1990-05-15', 'Male', '123 Đường ABC, Hà Nội'),
('Trần Thị B', '1985-09-20', 'Female', '456 Đường DEF, TP HCM'),
('Lê Minh C', '2000-01-10', 'Male', '789 Đường GHI, Đà Nẵng');

CREATE TABLE IF NOT EXISTS Doctor (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    specialty VARCHAR(255),
    contact_info VARCHAR(255),
    hospital_affiliation VARCHAR(255)
);
INSERT INTO Doctor (name, specialty, contact_info, hospital_affiliation)
VALUES 
('Dr. Nguyễn Văn D', 'Cardiology', '0981234567', 'Bệnh viện A'),
('Dr. Trần Thị E', 'Pediatrics', '0912345678', 'Bệnh viện B'),
('Dr. Lê Minh F', 'Orthopedics', '0934567890', 'Bệnh viện C');

CREATE TABLE IF NOT EXISTS Medicine (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    dosage VARCHAR(255),
    frequency VARCHAR(255),
    form ENUM('Tablet', 'Syrup', 'Injection', 'Topical') NOT NULL,
    description TEXT,
    manufacturer VARCHAR(255)
);
INSERT INTO Medicine (name, dosage, frequency, form, description, manufacturer)
VALUES 
('Paracetamol', '500mg', '3 lần/ngày', 'Tablet', 'Thuốc giảm đau, hạ sốt', 'PharmaCo'),
('Amoxicillin', '250mg', '2 lần/ngày', 'Capsule', 'Kháng sinh điều trị nhiễm khuẩn', 'MediPharm'),
('Ibuprofen', '200mg', '3 lần/ngày', 'Tablet', 'Thuốc giảm đau, chống viêm', 'HealthPharm');

CREATE TABLE IF NOT EXISTS Inventory (
    id INT AUTO_INCREMENT PRIMARY KEY,
    medicine_id INT,
    quantity_available INT,
    location VARCHAR(255),
    FOREIGN KEY (medicine_id) REFERENCES Medicine(id) ON DELETE CASCADE
);
INSERT INTO Inventory (medicine_id, quantity_available, location)
VALUES 
(1, 100, 'Kho A'),
(2, 50, 'Kho B'),
(3, 150, 'Kho C');

CREATE TABLE IF NOT EXISTS Prescription (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    date_issued DATE,
    status ENUM('Issued', 'Fulfilled', 'Cancelled') NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patient(id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctor(id) ON DELETE CASCADE
);
INSERT INTO Prescription (patient_id, doctor_id, date_issued, status)
VALUES 
(1, 1, '2024-11-10', 'Issued'),
(2, 2, '2024-11-11', 'Issued'),
(3, 3, '2024-11-12', 'Issued');

CREATE TABLE IF NOT EXISTS patient_medicine (
    patient_id INT,
    medicine_id INT,
    dosage VARCHAR(255),
    frequency VARCHAR(255),
    date_start DATE,
    date_end DATE,
    PRIMARY KEY (patient_id, medicine_id),
    FOREIGN KEY (patient_id) REFERENCES Patient(id) ON DELETE CASCADE,
    FOREIGN KEY (medicine_id) REFERENCES Medicine(id) ON DELETE CASCADE
);
INSERT INTO patient_medicine (patient_id, medicine_id, dosage, frequency, date_start, date_end)
VALUES 
(1, 1, '500mg', '3 lần/ngày', '2024-11-10', '2024-11-15'),
(1, 2, '250mg', '2 lần/ngày', '2024-11-10', '2024-11-15'),
(2, 3, '200mg', '3 lần/ngày', '2024-11-11', '2024-11-16'),
(3, 1, '500mg', '3 lần/ngày', '2024-11-12', '2024-11-17');

CREATE TABLE IF NOT EXISTS Prescription_Log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    prescription_id INT,
    action VARCHAR(255),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (prescription_id) REFERENCES Prescription(id) ON DELETE CASCADE
);
INSERT INTO Prescription_Log (prescription_id, action)
VALUES 
(1, 'Medicine dispensed'),
(2, 'Medicine dispensed'),
(3, 'Medicine dispensed');

